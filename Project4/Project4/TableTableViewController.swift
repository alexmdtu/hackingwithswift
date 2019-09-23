//
//  TableTableViewController.swift
//  Project4
//
//  Created by Alexander Tu on 23.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site")!
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Website") as? ViewController else {
            return
        }
        vc.websites = websites
        vc.selectedIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
