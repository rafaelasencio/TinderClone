//
//  SettingsCell.swift
//  TinderClone
//
//  Created by Usuario on 04/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
