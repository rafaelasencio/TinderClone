//
//  SettingsHeader.swift
//  TinderClone
//
//  Created by Usuario on 03/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class SettingsHeader: UIView {
    
    
    //MARK: - Properties
    
    private var buttons = [UIButton]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        let button1 = createButton()
        let button2 = createButton()
        let button3 = createButton()
        
        addSubview(button1)
        button1.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [button2, button3])
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.anchor(top: topAnchor, left: button1.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }
    
    
    //MARK: - Actions
    
    @objc func handleSelectPhoto(){
        
    }
    
}
