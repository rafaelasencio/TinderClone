//
//  AuthService.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?)->Void){
        print("DEBUG: register user")
        //1º Upload photo
        Service.uploadImage(image: credentials.profileImage, completion: { (imageUrl) in
        //2º Register user
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if error != nil {
                    print("DEBUG: Error creating user \(error!.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                let data = ["email": credentials.email,
                            "fullname": credentials.fullname,
                            "imageUrl":imageUrl,
                            "uid":uid,
                "age":18] as [String: Any]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        })
    }
    
    static func logUserIn(withEmail email: String, password: String,
                          completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
