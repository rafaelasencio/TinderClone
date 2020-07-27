//
//  CardView.swift
//  TinderClone
//
//  Created by Usuario on 27/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    //MARK: - Properties
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "jane2")
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        
        let attrText = NSMutableAttributedString(string: "Jane Doe", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        
        attrText.append(NSAttributedString(string: " 20", attributes: [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
        
        lbl.attributedText = attrText
        return lbl
    }()
    
    private lazy var infoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureGestureRecognizers()
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        // Add gradient layer before add labels
        configureGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // We access to the self frame one time the view is loaded
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    //MARK: - Helpers
    
    func configureGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    func configureGestureRecognizers(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: nil)
        switch sender.state {
            

        case .began: print("DEBUG: empezo a mover")
        case .changed: print("DEBUG: cambio")
            let degrees = translation.x / 20
            let angle = degrees * .pi / 180
            let rotationalTransform = CGAffineTransform(rotationAngle: angle)
            self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
        case .ended: print("DEBUG: termino")
        @unknown default: break
        }
    }
    
    @objc func handleChangePhoto(sender: UIPanGestureRecognizer){
        print("handleChangePhoto")
    }
}
