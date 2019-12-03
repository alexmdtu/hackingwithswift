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
    
    weak var delegate: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        // todo: save note when leaving detailView
        if let noteText = noteText {
            textView.text = noteText
        }
        
        // todo: add keyboard inset handling
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.saveNote(id: noteId!, text: textView.text, index: index ?? 0)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
        // has to have id, otherwise something went terribly wrong
        viewWillDisappear(true)
    }
}
