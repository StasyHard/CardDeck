//
//  Deck.swift
//  CardDeck
//
//  Created by Anastasia Reyngardt on 30.03.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation

struct Deck {
    private(set) var cards = [Card]()
    
    init() {
        for suit in Card.Suit.allCases {
            for rank in Card.Rank.all {
                cards.append(Card(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int.random(in: 0..<self)
        } else if self < 0 {
            return -Int.random(in: 0..<abs(self))
        } else {
            return 0
        }
    }
}
