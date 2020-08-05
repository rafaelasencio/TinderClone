//
//  SettingsCell.swift
//  TinderClone
//
//  Created by Usuario on 04/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    //MARK: - Properties
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Enter value here..."
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    var sliderStack = UIStackView()
    
    var viewModel: SettingsViewModel! {
        didSet {
            configure()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(inputField)
        inputField.fillSuperview()
        
        minAgeLabel.text = "Min: 18"
        maxAgeLabel.text = "Max: 60"
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel, minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel, maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        sliderStack.spacing = 16
        sliderStack.axis = .vertical
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 24, paddingRight: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func createAgeRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        return slider
    }
    
    //Execute when viewModel is instantiate
    func configure() {
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
    }
    
    //MARK: - Actions
    
    @objc func handleAgeRangeChanged(){
        
    }
}
