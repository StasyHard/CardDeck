//
//  ViewController.swift
//  CardDeck
//
//  Created by Anastasia Reyngardt on 30.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var cardViews: [CardView]!
    
    private var deck = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [Card]()
        for _ in 1...((cardViews.count + 1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = true
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
        }
    }


}

