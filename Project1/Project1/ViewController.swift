//
//  ViewController.swift
//  Project1
//
//  Created by Alexander Tu on 18.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var counters = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        loadPictures()
        
        let defaults = UserDefaults.standard
        
        if let savedCounters = defaults.object(forKey: "counters") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                counters = try jsonDecoder.decode([Int].self, from: savedCounters)
            } catch {
                print("Failed to load counters")
            }
        }
        
        print(counters)
    }
    
    func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                self.pictures.append(item)
            }
        }
        self.pictures.sort()
        
        if counters.isEmpty {
            counters = Array(repeating: 0, count: pictures.count)
        }
        
        tableView.reloadData()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(counters) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "counters")
        } else {
            print("Failed to save counters.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageIndex = indexPath.row + 1
            vc.pictureCount = pictures.count
            
            counters[indexPath.row] += 1
            save()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["This is my favorite app!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

