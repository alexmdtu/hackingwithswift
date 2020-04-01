//
//  ViewController.swift
//  Project39-XCTest
//
//  Created by Alexander Tu on 01.04.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Table View Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.allWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let word = playData.allWords[indexPath.row]
        cell.textLabel?.text = word
        return cell
    }
}

