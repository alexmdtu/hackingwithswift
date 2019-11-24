//
//  DetailViewController.swift
//  Milestone5
//
//  Created by Alexander Tu on 24.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var picture: UIImageView!
    
    var pic: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let pic = pic {
            let path = getDocumentsDirectory().appendingPathComponent(pic.image)
            picture.image = UIImage(contentsOfFile: path.path)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
