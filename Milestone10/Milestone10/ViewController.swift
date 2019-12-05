//
//  ViewController.swift
//  Milestone10
//
//  Created by Alexander Tu on 05.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    var topText = ""
    var bottomText = ""
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let importButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        let topTextButton = UIBarButtonItem(title: "Set top text", style: .plain, target: self, action: #selector(setTopText))
        let bottomTextButton = UIBarButtonItem(title: "Set bottom text", style: .plain, target: self, action: #selector(setBottomText))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [shareButton, importButton]
        navigationItem.leftBarButtonItems = [topTextButton, bottomTextButton]
    }

    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)
        originalImage = image
        
        drawMeme(loadedImage: image)
    }
    
    func drawMeme(loadedImage: UIImage) {
        let renderer = UIGraphicsImageRenderer(size: loadedImage.size)

        let img = renderer.image { ctx in
            // draw image
            loadedImage.draw(at: CGPoint(x: 0, y: 0))
            
            // setup meme format
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 84),
                .paragraphStyle: paragraphStyle,
                .strokeWidth: -3.0,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white
            ]

            // draw top text
            let width = loadedImage.size.width
            let height = loadedImage.size.height
            
            let attributedTopString = NSAttributedString(string: topText, attributes: attrs)
            attributedTopString.draw(with: CGRect(x: 0, y: 0, width: width, height: height), options: .usesLineFragmentOrigin, context: nil)

            // draw bottom text
            let attributedBottomString = NSAttributedString(string: bottomText, attributes: attrs)
            attributedBottomString.draw(with: CGRect(x: 0, y: height - 120, width: width, height: height), options: .usesLineFragmentOrigin, context: nil)
        }

        imageView.image = img
    }
    
    @objc func setTopText() {
        let ac = UIAlertController(title: "Set top text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let message = ac?.textFields?[0].text else { return }
            self?.topText = message
                        
            if let image = self?.originalImage {
                self?.drawMeme(loadedImage: image)
            }
        }
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func setBottomText() {
        let ac = UIAlertController(title: "Set bottom text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let message = ac?.textFields?[0].text else { return }
            self?.bottomText = message
            
            if let image = self?.originalImage {
                self?.drawMeme(loadedImage: image)
            }
        }
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

