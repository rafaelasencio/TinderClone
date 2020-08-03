//
//  HomeNavigationStackView.swift
//  TinderClone
//
//  Created by Usuario on 27/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

protocol HomeNavigationStackViewDelegate: class {
    func showSettings()
    func showMessages()
}

class HomeNavigationStackView: UIStackView {
    
    //MARM: - Properties
    
    //this variable is weak to prevent retained cycles cause delegate reference on HomeController
    weak var delegate: HomeNavigationStackViewDelegate?
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    
    //MARM: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        [settingsButton, UIView(), tinderIcon, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingsButton.addTarget(self, action: #selector(handleShowSetting), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleShowSetting(){
        delegate?.showSettings()
    }
    
    @objc func handleShowMessages(){
        delegate?.showMessages()
    }
}

extension HomeController: HomeNavigationStackViewDelegate {
    
    func showSettings() {
        let controller = SettingsController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func showMessages() {
        
    }
    
    
}
