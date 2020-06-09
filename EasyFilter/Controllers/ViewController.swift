//
//  ViewController.swift
//  EasyFilter
//
//  Created by Emre Çelik on 8.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cardStack = SwipeCardStack()

    let cardModels = [
        TinderCardModel(name: "",
                        age: 26,
                        occupation: "",
                        image: UIImage(named: "monalisa")),
        TinderCardModel(name: "",
                        age: 27,
                        occupation: "",
                        image: UIImage(named: "monalisa")),
        TinderCardModel(name: "",
                        age: 23,
                        occupation: "",
                        image: UIImage(named: "monalisa")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        cardStack.dataSource = self
        cardStack.delegate = self
        view.addSubview(cardStack)
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        cardStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        cardStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        cardStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        cardStack.frame = self.view.layer.bounds
    }

//    func card(fromImage image: UIImage) -> SwipeCard {
//        let card = SwipeCard()
//        card.swipeDirections = [.left, .right]
//        card.content = UIImageView(image: image)
//
//        let leftOverlay = UIView()
//        leftOverlay.backgroundColor = .red
//
//        let rightOverlay = UIView()
//        rightOverlay.backgroundColor = .green
//
//        card.setOverlays([.left: leftOverlay, .right: rightOverlay])
//
//        return card
//    }

}

extension ViewController: SwipeCardStackDelegate {

}

extension ViewController: SwipeCardStackDataSource {
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
//        card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)

        return card
    }

    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
       return cardModels.count
    }

}

