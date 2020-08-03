//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit


class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private var registrationViewModel = RegistrationViewModel()
    
    private let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        btn.clipsToBounds = true
        return btn
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecureField: true)
    
    private var profileImage: UIImage?
    
    private let registrationButton: AuthButton = {
        let btn = AuthButton(title: "Register", type: .system)
        btn.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return btn
    }()
    
    private let goToLogInButton: UIButton = {
        let btn = UIButton(type: .system)
        let attrTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                  attributes: [ .foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)])
        attrTitle.append(NSAttributedString(string: "Sign In",
                                            attributes: [.foregroundColor : UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attrTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldObservers()
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleSelectPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration(){
        guard let email = emailTextField.text,
            let fullname = fullnameTextField.text,
            let password = passwordTextField.text,
            let profileImage = profileImage else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, profileImage: profileImage)
        
        AuthService.registerUser(withCredentials: credentials) { (error) in
            if error != nil {
                print("DEBUG: error \(error!.localizedDescription)")
                return
            }
            print("DEBUG: successfully registered")
            
        }
    }
    
    //Lleva al usuario a la pagina para iniciar sesion
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    //Asigna los valores de los TextFields(email, fullname y password) al RegistrationViewModel
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            registrationViewModel.email = sender.text
        } else if sender == passwordTextField {
            registrationViewModel.password = sender.text
        } else {
            registrationViewModel.fullname = sender.text
        }
        print("DEBUG: is valid: \(registrationViewModel.formIsValid)")
        checkFormStatus()
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        configureGradientLayer()
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 275, width: 275)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 8)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, fullnameTextField ,passwordTextField, registrationButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToLogInButton)
        goToLogInButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
    
    //Ejecuta el método textDidChange cuando el usuario termina de escribir
    func configureTextFieldObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    //Activa/Desactiva el boton en funcion de si los Textfields tienen valor
    func checkFormStatus(){
        if registrationViewModel.formIsValid {
            registrationButton.isEnabled = true
            registrationButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            registrationButton.isEnabled = false
            registrationButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /* Se ejecuta cuando el usuario selecciona una foto de la galeria o camara
       y asigna la foto a la del perfil de usuario*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
    }
}
