//
//  DetailViewController.swift
//  Project38-GitHubCommits
//
//  Created by Alexander Tu on 28.03.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var detailLabel: UILabel!
    var detailItem: Commit?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let detail = self.detailItem {
            detailLabel.text = detail.message
            // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1/\(detail.author.commits.count)", style: .plain, target: self, action: #selector(showAuthorCommits))
        }
    }
}
