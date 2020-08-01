//
//  HomeController.swift
//  TinderClone
//
//  Created by Usuario on 27/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    
    //MARM: - Properties
    
    private let topStack = HomeNavigationStackView()
    private let bottomStack = ButtomControlsStackView()
    
    private var viewModels = [CardViewModel]() {
        didSet {
            configureCards()
        }
    }
    
    private let deckView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    //MARM: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureUI()
        fetchUsers()
//        logout()
    }
    
    //MARM: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stackView.bringSubviewToFront(deckView)
    }
    
    func configureCards(){
        print("DEBUG: configure cards now")
        
        viewModels.forEach { (viewModel) in
            let cardView = CardView(viewModel: viewModel)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    func presentLoginController(){
        //Its called after make API call, to go back in the main thread
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //MARM: - API
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { (user) in
            print("DEBUG: user is \(user.name)")
            
        }
    }
    
    func fetchUsers(){
        Service.fetchUsers { (users) in
            print("DEBUG: USERS \(users)")
            //map users array into the CardViewModel array. $0 represent each user
            self.viewModels = users.map({CardViewModel(user: $0)})
            
        }
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            print("DEBUG: user not logged in")
            presentLoginController()
        } else {
            print("DEBUG: user is logged in")
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("DEBUG: error sign out")
        }
    }
}
