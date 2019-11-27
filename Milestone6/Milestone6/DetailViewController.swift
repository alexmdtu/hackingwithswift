//
//  DetailViewController.swift
//  Milestone6
//
//  Created by Alexander Tu on 27.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailItem: Country?

    @IBOutlet var name: UILabel!
    @IBOutlet var capital: UILabel!
    @IBOutlet var population: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let detailItem = detailItem else { return }
        print(detailItem)
        
        name.text = detailItem.name
        
        capital.text = detailItem.capital
        population.text = "\(detailItem.population)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
