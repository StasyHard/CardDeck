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
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCard(_:)))
            cardView.addGestureRecognizer(tapGesture)
        }
    }
    
    private var faseUpCardViews: [CardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden }
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chousenCardView = recognizer.view as? CardView {
                UIView.transition(with: chousenCardView,
                                  duration: 0.6,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                                    chousenCardView.isFaceUp = !chousenCardView.isFaceUp
                },
                                  completion: { finished in
                                    if self.faseUpCardViews.count == 2 {
                                        self.faseUpCardViews.forEach { cardView in
                                            UIView.transition(with: cardView,
                                                              duration: 0.6,
                                                              options: [.transitionFlipFromLeft],
                                                              animations: {
                                                                cardView.isFaceUp = false
                                            })
                                        }
                                    }
                                    
                })
            }
        default: break
        }
    }
    
    
}

