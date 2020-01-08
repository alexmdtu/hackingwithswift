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
                print(countries)
                print(capitals)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPairs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as? CardCell else {
            fatalError()
        }
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        cell.cardText.text = countries[indexPath.item]
        
        return cell
    }
}

