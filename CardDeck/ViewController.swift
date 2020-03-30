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
    
    private var faseUpCardViewsMatch: Bool {
        return  faseUpCardViews.count == 2 &&
            faseUpCardViews[0].rank == faseUpCardViews[1].rank &&
            faseUpCardViews[0].suit == faseUpCardViews[1].suit
    }
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chousenCardView = recognizer.view as? CardView {
                //Анимация переворота карты
                UIView.transition(with: chousenCardView,
                                  duration: 0.6,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                                    chousenCardView.isFaceUp = !chousenCardView.isFaceUp
                },
                                  completion: { finished in
                                    //если карты совпали увеличиваем карты, потом уменьшаем и они пропадают
                                    if self.faseUpCardViewsMatch {
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.6,
                                            delay: 0,
                                            options: [],
                                            animations: {
                                                self.faseUpCardViews.forEach {
                                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                                }
                                        }) //completion
                                        { position in
                                            UIViewPropertyAnimator.runningPropertyAnimator(
                                                withDuration: 0.75,
                                                delay: 0,
                                                options: [],
                                                animations: {
                                                    self.faseUpCardViews.forEach {
                                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                        $0.alpha = 0
                                                    }
                                            }) //completion
                                            { position in
                                                self.faseUpCardViews.forEach {
                                                    $0.isHidden = true
                                                    $0.alpha = 1
                                                    $0.transform = .identity
                                                }
                                            }
                                        }
                                    } //если карты две и не совпали, переворачиваем обратно лицом вниз
                                    else if self.faseUpCardViews.count == 2 {
                                        self.faseUpCardViews.forEach { cardView in
                                            UIView.transition(
                                                with: cardView,
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

