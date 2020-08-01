//
//  User.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

struct User {
    var name: String
    var age: Int
    var email: String
    let uid: String
    let profileImageUrl: String
//    var images: [UIImage]
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
