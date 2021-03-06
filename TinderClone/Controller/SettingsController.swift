//
//  SettingsController.swift
//  TinderClone
//
//  Created by Usuario on 03/08/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

protocol SettingsControllerDelegate: class {
    func settingsController(_ controller: SettingsController, wantsToUpdate user: User )
}

class SettingsController: UITableViewController {
    
    
    //MARK: - Properties
    private var user: User
    private lazy var headerView = SettingsHeader(user: user)
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    
    weak var delegate: SettingsControllerDelegate?
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //Initializer called in HomeController when user press Settings button
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        headerView.delegate = self
        imagePicker.delegate = self
        
        tableView.separatorStyle = .none
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        //Register SettingsCell
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        //Set header view
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    func setHeaderImage(_ image: UIImage?) {
        
        headerView.buttons[imageIndex].setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK: - Actions
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    /*When user press done button the view end editing and the method handleUpdateUserInfo in SettingCell is called.
    With delegate method, the user values updated are passed to the HomeController user */
    @objc func handleDone(){
        print("DEBUG: DONE")
        view.endEditing(true)
        delegate?.settingsController(self, wantsToUpdate: user)
    }
    
}

//MARK: - SettingsHeaderDelegate

extension SettingsController: SettingsHeaderDelegate {
    
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        self.imageIndex = index
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

//MARK: - UIImagePickerControllerDelegate

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        setHeaderImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension SettingsController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSections(rawValue: indexPath.section) else { return cell}
        //user comes from the SettingsController initializer which in turn comes from the HomeController
        let viewModel = SettingsViewModel(user: user, section: section)
        cell.delegate = self
        //Execute didSet block in SettingsCell
        cell.viewModel = viewModel
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SettingsController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSections(rawValue: section) else { return nil }
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSections(rawValue: indexPath.section) else { return 0 }
        return section == .ageRange ? 96 : 44
    }
}

//MARK: - SettingsCellDelegate

extension SettingsController: SettingsCellDelegate {
    
    func settingsCell(_ cell: SettingsCell, wantsToUpdateAgeRangeWith sender: UISlider) {
        print("DEBUG: update age preferences here")
    }
    
    
    //Recieve value from textField and update the user value for specific section
    func settingsCell(_ cell: SettingsCell, wantsToUpdateUserWith value: String, for section: SettingsSections) {
        switch section {
            
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? user.age
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
        print("DEBUG: update user info")
    }
}
