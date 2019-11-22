//
//  ViewController.swift
//  Milestone4
//
//  Created by Alexander Tu on 21.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var questions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load questions
        if let questionsURL = Bundle.main.url(forResource: "questions", withExtension: "txt") {
            if let questionsContent = try? String(contentsOf: questionsURL) {
                questions = questionsContent.components(separatedBy: "\n")
                questions.shuffle()
            }
        }
        
        // setup clue as underscores
        view = UIView()
        view.backgroundColor = .white
        
        // setup letter buttons, take similar approach like in swifty words game
        
        // create AC for wrong answers and correct answer, loading next question
    }


}

