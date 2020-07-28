//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit


class LoginController: UIViewController {
    
    
    //MARK: - Properties
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password", isSecureField: true)
        return tf
    }()
    
    private let authButton: AuthButton = {
        let btn = AuthButton(title: "Log In", type: .system)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let goToRegistrationButton: UIButton = {
        let btn = UIButton(type: .system)
        let attrTitle = NSMutableAttributedString(string: "Don´t have an account?  ",
                                                  attributes: [ .foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)])
        attrTitle.append(NSAttributedString(string: "Sign Up",
                                            attributes: [.foregroundColor : UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]))
        btn.setAttributedTitle(attrTitle, for: .normal)
        btn.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    
    @objc func handleLogin(){
        
    }
    
    @objc func handleShowRegistration(){
        
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer() //Declared in Extensions
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 100)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, authButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    
}
