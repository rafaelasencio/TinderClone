//
//  SettingsHeader.swift
//  TinderClone
//
//  Created by Usuario on 03/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit
import SDWebImage

protocol SettingsHeaderDelegate: class {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int)
}

class SettingsHeader: UIView {
    
    
    //MARK: - Properties
    
    private let user: User
    weak var delegate: SettingsHeaderDelegate?
    var buttons = [UIButton]()
    //variables are lazy because we are declaring the method out of any initializer or different method
    lazy var button1 = createButton(0)
    lazy var button2 = createButton(1)
    lazy var button3 = createButton(2)
    
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        backgroundColor = .systemGroupedBackground
        
        buttons.append(button1) //another option: buttons.append(createButton(0))
        buttons.append(button2)
        buttons.append(button3)
        
        addSubview(button1)
        button1.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [button2, button3])
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.anchor(top: topAnchor, left: button1.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        loadUserPhotos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func createButton(_ index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.tag = index
        return button
    }
    
    func loadUserPhotos() {
        let imageURLs = user.imageURLs.map{(URL(string: $0))}
        
        for (index, url) in imageURLs.enumerated() {
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                self.buttons[index].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    
    //MARK: - Actions
    
    @objc func handleSelectPhoto(sender: UIButton){
        delegate?.settingsHeader(self, didSelect: sender.tag)
    }
    
}
