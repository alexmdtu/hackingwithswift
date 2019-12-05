//
//  DetailViewController.swift
//  Project1
//
//  Created by Alexander Tu on 19.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedImageIndex: Int?
    var pictureCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let index = selectedImageIndex, let pictureCount = pictureCount {
            title = "Picture \(index) of \(pictureCount)"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            // old loading of image
            //imageView.image = UIImage(named: imageToLoad)
            
            // image with text overlay
            let loadedImage = UIImage(named: imageToLoad)!
            let renderer = UIGraphicsImageRenderer(size: loadedImage.size)

            let img = renderer.image { ctx in
                loadedImage.draw(at: CGPoint(x: 0, y: 0))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left

                let attrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 35),
                    .paragraphStyle: paragraphStyle
                ]

                let string = "From Storm Viewer"
                let attributedString = NSAttributedString(string: string, attributes: attrs)

                attributedString.draw(with: CGRect(x: 15, y: 50, width: loadedImage.size.width, height: loadedImage.size.height), options: .usesLineFragmentOrigin, context: nil)
            }

            imageView.image = img
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let imageName = selectedImage else {
            return
        }
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
