//
//  ViewController.swift
//  Milestone11
//
//  Created by Alexander Tu on 08.01.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var countries = [String]()
    var capitals = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let cardContentsURL = Bundle.main.url(forResource: "capitalsCountries", withExtension: "txt") {
            if let cardContents = try? String(contentsOf: cardContentsURL) {
                var allPairs = cardContents.components(separatedBy: "\n")
                allPairs.removeLast() //remove blank string array element due to last line break
                print(allPairs)
                countries = allPairs.map { $0.components(separatedBy: ";")[0] }
                capitals = allPairs.map { $0.components(separatedBy: ";")[1] }
                print(countries)
                print(capitals)
            }
        }
    }
    

}

