//
//  AuthenticationViewModel.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import Foundation

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModel {
    
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
    
}

struct RegistrationViewModel: AuthenticationViewModel {
    
    var email: String?
    var fullname: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            fullname?.isEmpty == false &&
            password?.isEmpty == false
    }
}
