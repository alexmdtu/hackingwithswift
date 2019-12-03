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
        
        // todo: add delete button and compose button
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        toolbarItems = [deleteButton, spacer, composeButton]
        
        // todo: add share button
        
        // todo: add keyboard inset handling
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
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
}
