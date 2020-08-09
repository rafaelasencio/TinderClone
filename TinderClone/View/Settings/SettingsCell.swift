//
//  SettingsCell.swift
//  TinderClone
//
//  Created by Usuario on 04/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

protocol SettingsCellDelegate {
    func settingsCell(_ cell: SettingsCell, wantsToUpdateUserWith value: String, for section: SettingsSections)
    func settingsCell(_ cell: SettingsCell, wantsToUpdateAgeRangeWith sender: UISlider)
}
class SettingsCell: UITableViewCell {
    
    //MARK: - Properties
    
    var delegate: SettingsCellDelegate?
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
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
        selectionStyle = .none
        addSubview(inputField)
        inputField.fillSuperview() 
        
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
        //Hide Textfield or Slider depending section
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
        
        //Set labels with slider value
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
    }
    
    //MARK: - Actions
    
    //Set text for label depending witch Slider is changing
    @objc func handleAgeRangeChanged(sender: UISlider){
        if sender == minAgeSlider {
            minAgeLabel.text = viewModel.minAgeLabelText(forValue: sender.value)
        } else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: sender.value)
        }
    }
    
    @objc func handleUpdateUserInfo(sender: UITextField){
        
        guard let value = sender.text else { return }
        delegate?.settingsCell(self, wantsToUpdateUserWith: value, for: viewModel.section)
    }
    
}
