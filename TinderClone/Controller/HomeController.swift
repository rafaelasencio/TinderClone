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
    
    
    //MARK: - Properties
    
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureUI()
        fetchUsers()
//        logout()
    }
    
    //MARK: - Helpers
    
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
    
    
    //Se recorre el array de CardViewModels con los valores de usuarios y creando una instancia de CardView para añadirla a la vista deckView en el HomeController
    func configureCards(){
        print("DEBUG: configure cards now")
        
        viewModels.forEach { (viewModel) in
            let cardView = CardView(viewModel: viewModel)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    //Presenta la pagina para iniciar sesion
    func presentLoginController(){
        //Its called after make API call, to go back in the main thread
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { (user) in
            print("DEBUG: user is \(user.name)")
            
        }
    }
    
    //
    func fetchUsers(){
        Service.fetchUsers { (users) in
            print("DEBUG: USERS \(users)")
            //map users array into the CardViewModel array. $0 represent each user
            self.viewModels = users.map({CardViewModel(user: $0)})
            
        }
    }
    
    //Comprueba si el usuario esta logeado
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            print("DEBUG: user not logged in")
            presentLoginController()
        } else {
            print("DEBUG: user is logged in")
        }
    }
    
    //Cerrar sesion
    func logout(){
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("DEBUG: error sign out")
        }
    }
}
