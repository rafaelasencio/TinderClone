//
//  Service.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import Foundation
import Firebase

struct Service {
    
    //Upload profileImage of user and retrieve url of this photo uploaded
    static func uploadImage(image: UIImage, completion: @escaping(String)-> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("DEBUG: Error uploading image \(error!.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
    //Devuelve los datos del usuario que inicia sesion
    static func fetchUser(withUid uid: String, completion: @escaping(User)->Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            print("DEBUG: snapshot \(snapshot?.data())")
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    //Loop throw all users in Firestore to instantiate and return an array with total users
    static func fetchUsers(completion: @escaping([User])->Void){
        var users = [User]()
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary) //Accede a los valores de los usuarios en Firestore
                
                users.append(user)
                //Cuando se termina de recorrer todos los datos, se devuelve el array con todos los usuarios
                if users.count == snapshot?.documents.count{
                    completion(users)
                }
            })
        }
    }
    
}
