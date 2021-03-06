//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class CardViewModel {
    
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    
    private var imageIndex = 0
    
    var imageUrl: URL?
    
    init(user: User) {
        self.user = user
        
        let attrText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        
        attrText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
        
        self.userInfoText = attrText
        
//        self.imageUrl = URL(string: user.imageURLs)
        self.imageURLs = user.imageURLs
        self.imageUrl = URL(string: self.imageURLs[0])
    }
    
    func showNextPhoto(){
//        guard imageIndex < user.images.count - 1 else {return}
//        imageIndex += 1
//        self.imageToShow = user.images[imageIndex]
    }
    
    func showPreviousPhoto(){
//        guard imageIndex > 0 else {return}
//        imageIndex -= 1
//        self.imageToShow = user.images[imageIndex]
    }
}
