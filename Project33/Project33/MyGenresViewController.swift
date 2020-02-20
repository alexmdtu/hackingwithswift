//
//  MyGenresViewController.swift
//  Project33
//
//  Created by Alexander Tu on 20.02.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit
import CloudKit

class MyGenresViewController: UITableViewController {

    let container = CKContainer(identifier: "iCloud.com.test.Project33")
    
    var myGenres: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedGenres = defaults.object(forKey: "myGenres") as? [String] {
            myGenres = savedGenres
        } else {
            myGenres = [String]()
        }
        
        title = "Notify me about..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @objc func saveTapped() {
        let defaults = UserDefaults.standard
        defaults.set(myGenres, forKey: "myGenres")
        
        let database = container.publicCloudDatabase
        
        database.fetchAllSubscriptions { [unowned self] (subscriptions, error) in
            if error == nil {
                if let subscriptions = subscriptions {
                    for subscription in subscriptions {
                        database.delete(withSubscriptionID: subscription.subscriptionID) { (str, err) in
                            if error != nil {
                                print("Some issues when deleting subscriptions appeared: \(error!.localizedDescription)")
                            }
                        }
                    }
                }
                // more code here
                for genre in self.myGenres {
                    let predicate = NSPredicate(format: "genre = %@", genre)
                    let subscription = CKQuerySubscription(recordType: "Whistles", predicate: predicate, options: .firesOnRecordCreation)
                    
                    let notification = CKSubscription.NotificationInfo()
                    notification.alertBody = "There is a new whistle in the \(genre)."
                    notification.soundName = "default"
                    
                    subscription.notificationInfo = notification
                    
                    database.save(subscription) { (result, error) in
                        if let error = error {
                            print("Something went wrong when saving the subscription: \(error.localizedDescription)")
                        }
                    }
                }
            } else {
                print("Some issues appeared when trying to fetch subscriptions: \(error!.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectGenreTableViewController.genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let genre = SelectGenreTableViewController.genres[indexPath.row]
        cell.textLabel?.text = genre
        
        if myGenres.contains(genre) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let selectedGenre = SelectGenreTableViewController.genres[indexPath.row]
            
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                myGenres.append(selectedGenre)
            } else {
                cell.accessoryType = .none
                
                if let index = myGenres.firstIndex(of: selectedGenre) {
                    myGenres.remove(at: index)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
