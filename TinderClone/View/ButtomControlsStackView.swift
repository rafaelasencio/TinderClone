//
//  ButtomControlsStackView.swift
//  TinderClone
//
//  Created by Usuario on 27/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class ButtomControlsStackView: UIStackView {
    
    //MARM: - Properties
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superlikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    
    
    
    //MARM: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
        
        refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superlikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [refreshButton, dislikeButton, superlikeButton, likeButton, boostButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
