//
//  DetailViewController.swift
//  Milestone8
//
//  Created by Alexander Tu on 02.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    
    var noteText: String?
    var noteId: UUID?
    var index: Int?
    var indexPath: IndexPath?
    
    weak var delegate: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        if let noteText = noteText {
            textView.text = noteText
        }
        
        // add custom back button
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = backButton
        
        // adding tool bar buttons
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        toolbarItems = [deleteButton, spacer, composeButton]
        
        // add share button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // todo: add keyboard inset handling
        
    }
    
    @objc func done() {
        // has to have id, otherwise something went terribly wrong
        delegate.saveNote(id: noteId!, text: textView.text, index: index ?? 0)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func createNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // create new id for new note
            vc.noteId = UUID()
            vc.delegate = delegate
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func deleteNote() {
        if let indexPath = indexPath {
            delegate.deleteNote(indexPath: indexPath)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func shareTapped() {
        guard let text = textView.text else {
            print("No text found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
