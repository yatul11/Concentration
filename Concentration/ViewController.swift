//
//  ViewController.swift
//  Concentration
//
//  Created by Ivan Lutaenko on 9/29/18.
//  Copyright © 2018 Ivan Lutaenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numbersOfPairsOfCards)
    
    var numbersOfPairsOfCards:Int{
        return (cardButtons.count + 1)/2
    }

    private(set) var flipCount: Int = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Card is not in cardButtons array")
        }
        flipCount+=1
        if(game.counterOfMatchedCards == (cardButtons.count + 1)/2){
            finishedGameAlert()
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle(nil, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 1, green: 0.6510223746, blue: 0, alpha: 1)
                button.isEnabled = card.isMatched ? false:true
             }
        }
    }
    
    
    private var emojiChoices = ["🎃","👻","💀", "👽", "🕷","😈","🕸","😱","🙀"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
                let randomIndex = emojiChoices.count.arc4random
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func finishedGameAlert(){
        let alert = UIAlertController(title: "Congratulations", message: "You have matched all cards. Nice work!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

extension Int{
    var arc4random:Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

