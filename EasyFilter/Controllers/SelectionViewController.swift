//
//  SelectionViewController.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    let cardStack = SwipeCardStack()
    
    var population = [Filter]()
    var cardModels = [TinderCardModel]()
    
    var originalImage: UIImage!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        population = GeneticAlgorithm().randomPopulation()
        newGeneration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        cardStack.delegate = self
        cardStack.dataSource = self
        view.addSubview(cardStack)
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        cardStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        cardStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        cardStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        cardStack.frame = self.view.layer.bounds
    }
    
    private func newGeneration() {
        var models = [TinderCardModel]()
        for filter in population {
            models.append(TinderCardModel(name: "", age: 0, occupation: "", image: image.getFilteredImage(filter: filter)))
        }
        cardModels = models
        cardStack.reloadData()
    }
    
    @IBAction func backTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SelectionViewController: SwipeCardStackDelegate {
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
        population = GeneticAlgorithm().calculate(items: population)
        newGeneration()
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(cardModels[index].name)")
        switch direction {
        case .right:
            population[index].weight = 1
        case .up:
            population[index].weight = 3
        default:
            print("Default Swipe Direction")
        }
        
    }
}

extension SelectionViewController: SwipeCardStackDataSource {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .up, .right]
        for direction in card.swipeDirections {
            card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
        }
        
        let model = cardModels[index]
        card.content = TinderCardContentView(withImage: model.image)
        card.footer = TinderCardFooterView(withTitle: "", subtitle: "")
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }
    
}
