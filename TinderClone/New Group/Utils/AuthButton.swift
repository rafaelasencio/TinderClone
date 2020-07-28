//
//  AuthButton.swift
//  TinderClone
//
//  Created by Usuario on 28/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class AuthButton: UIButton {
    
    init(title: String, type: ButtonType) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
