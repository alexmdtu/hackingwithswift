//
//  DetailViewController.swift
//  Milestone1
//
//  Created by Alexander Tu on 22.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName: String?
    
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageName = imageName {
            image.image = UIImage(named: imageName)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = image.image else { return }
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

}
