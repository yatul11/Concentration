//
//  Concentration.swift
//  Concentration
//
//  Created by Ivan Lutaenko on 10/2/18.
//  Copyright © 2018 Ivan Lutaenko. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOneAndOnlyFaceUpCard:Int?{
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var counterOfMatchedCards = 0
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    counterOfMatchedCards+=1
                }
                cards[index].isFaceUp = true
            }
            else{
                // either no cards or 2 cards are face up
                indexOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        var preShuffleCards = [Card]()
        // create array with cards
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            preShuffleCards += [card, card]
        }
        // shuffle array with cards randomly
        for _ in 0..<preShuffleCards.count{
            let randomIndex = preShuffleCards.count.arc4random
            cards += [preShuffleCards[randomIndex]]
            preShuffleCards.remove(at: randomIndex)
        }
    }
}
