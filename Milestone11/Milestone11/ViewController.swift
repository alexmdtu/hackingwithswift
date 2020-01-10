//
//  ViewController.swift
//  Milestone11
//
//  Created by Alexander Tu on 08.01.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var allPairs = [String]()
    var countries = [String]()
    var capitals = [String]()
    var allText = [String]()
    
    var selectedCards = [Int]()
    var revealedCards = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load card text
        if let cardContentsURL = Bundle.main.url(forResource: "capitalsCountries", withExtension: "txt") {
            if let cardContents = try? String(contentsOf: cardContentsURL) {
                allPairs = cardContents.components(separatedBy: "\n")
                allPairs.removeLast() //remove blank string array element due to last line break
                print(allPairs)
                
                countries = allPairs.map { $0.components(separatedBy: ";")[0] }
                capitals = allPairs.map { $0.components(separatedBy: ";")[1] }
                
                allText = countries + capitals
                allText.shuffle()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allText.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as? CardCell else {
            fatalError()
        }
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        
        cell.cardText.text = allText[indexPath.item]
        // TODO: check if revealed card, disable selection, turn green
        if revealedCards.contains(indexPath.item) {
            cell.isUserInteractionEnabled = false
        } else if selectedCards.contains(indexPath.item) {
            cell.cardText.isHidden = false
            cell.select = true
        } else {
            cell.cardText.isHidden = true
            cell.select = false
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { fatalError() }
        
        if revealedCards.contains(indexPath.item) {
            cell.isUserInteractionEnabled = false
            print("already revealed")
        } else {
            selectedCards.append(indexPath.item)
            if selectedCards.count == 2 {
                cell.cardText.isHidden = false
                cell.select = true
                checkSelection()
            } else {
                cell.cardText.isHidden = false
                cell.select = true
            }
        }
    }
    
    func checkSelection() {
        // TODO: make more efficient check if it's capital or country card
        let firstCard = allText[selectedCards[0]]
        let secondCard = allText[selectedCards[1]]
        
        // TODO: reduce if pyramid
        if countries.contains(firstCard) && capitals.contains(secondCard) {
            if allPairs.contains(firstCard + ";" + secondCard) {
                print("Correct combination")
                revealedCards.append(selectedCards[0])
                revealedCards.append(selectedCards[1])
                selectedCards.removeAll()
                print(revealedCards)
            } else {
                removeSelectedCards()
            }
        } else if countries.contains(secondCard) && capitals.contains(firstCard) {
            if allPairs.contains(secondCard + ";" + firstCard) {
                print("Correct combination")
                revealedCards.append(selectedCards[0])
                revealedCards.append(selectedCards[1])
                selectedCards.removeAll()
                print(revealedCards)
            } else {
                removeSelectedCards()
            }
        } else {
            
            removeSelectedCards()
        }
        
        // idea: change to wrong answer marker, return to normal after next selection
        
        // remove selection, TODO, show wrong answers
        
    }
    
    func removeSelectedCards() {
        print("Wrong combination")
        for card in selectedCards {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: card, section: 0)) as? CardCell else { fatalError() }
            cell.cardText.isHidden = true
            cell.select = false
        }
        selectedCards.removeAll()
    }
}

