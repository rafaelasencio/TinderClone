//
//  SettingsController.swift
//  TinderClone
//
//  Created by Usuario on 03/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Lifecycle
    
    func configureUI(){
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
}
