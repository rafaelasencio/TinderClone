//
//  HomeController.swift
//  TinderClone
//
//  Created by Usuario on 27/07/2020.
//  Copyright © 2020 RafaelAB. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    
    //MARM: - Properties
    
    private let topStack = HomeNavigationStackView()
    
    private let bottomStack = ButtomControlsStackView()
    
    private let deckView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    //MARM: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCards()
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
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "jane1"), #imageLiteral(resourceName: "jane2")])
        let user2 = User(name: "Megan Fox", age: 25, images: [#imageLiteral(resourceName: "kelly1"), #imageLiteral(resourceName: "kelly2")])
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
}
