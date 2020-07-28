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
    
    private let selectPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return btn
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password", isSecureField: true)
        return tf
    }()
    
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
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleSelectPhoto(){
        
    }
    
    @objc func handleRegistration(){
        
    }
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
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
    
    
}
