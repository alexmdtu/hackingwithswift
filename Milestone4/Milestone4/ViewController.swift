//
//  ViewController.swift
//  Milestone4
//
//  Created by Alexander Tu on 21.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentAnswer: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var questions = [String]()
    var correctGuesses = [String]()
    
    var level = 0
    var tries = 5
    
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var alphabetArray = [String]()
        for letter in alphabet {
            alphabetArray.append(String(letter))
        }
        
        // load questions
        if let questionsURL = Bundle.main.url(forResource: "questions", withExtension: "txt") {
            if let questionsContent = try? String(contentsOf: questionsURL) {
                questions = questionsContent.components(separatedBy: "\n")
                // remove last entry due to line break
                questions.removeLast()
                questions.shuffle()
            }
        }
        
        // setup layout
        view = UIView()
        view.backgroundColor = .white
        
        // setup clue as underscores
        currentAnswer = UILabel()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: 55)
        currentAnswer.text = String(repeating: "_ ", count: questions[level].count)
        currentAnswer.numberOfLines = 0
        view.addSubview(currentAnswer)
        
        // setup 26 letter buttons, take similar approach like in swifty words game
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        
        let width = 36
        let height = 60
        var index = 0
        
        for row in 0..<3 {
            for col in 0..<9 {
                if index < 26 {
                    // create a new button and give it a big font size
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

                    // give the button some temporary text so we can see it on-screen
                    letterButton.setTitle(alphabetArray[index], for: .normal)

                    // calculate the frame of this button using its column and row
                    let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                    letterButton.frame = frame
                    
                    // add it to the buttons view
                    buttonsView.addSubview(letterButton)
                    index += 1
                    letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                }
            }
        }
                
        // setup autolayout
        NSLayoutConstraint.activate([
            currentAnswer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            buttonsView.widthAnchor.constraint(equalToConstant: 324),
            buttonsView.heightAnchor.constraint(equalToConstant: 180),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 100),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -120)
        ])
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        var prompt = ""
        
        if questions[level].contains(buttonTitle) {
            // correct guess
            correctGuesses.append(buttonTitle)
            for letter in questions[level] {
                let strLetter = String(letter)
                if correctGuesses.contains(strLetter) {
                    prompt += strLetter
                } else {
                    prompt += "_ "
                }
            }
            currentAnswer.text = prompt
            // won game
            print(prompt)
            print(questions[level])
            if prompt == questions[level] {
                let ac = UIAlertController(title: "You've won!", message: "You've guessed everything correctly", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart game", style: .default, handler: resetGame))
                present(ac, animated: true)
            }
        } else {
            // wrong guess
            tries -= 1
            let title = tries == 0 ? "You've lost!" : "Wrong answer!"
            let message = tries == 0 ? "Maybe next time" : "Try another answer. You have \(tries) tries left"
            let actionTitle = tries == 0 ? "Restart game" : "Continue"
            let handler = tries == 0 ? resetGame : nil

            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
            present(ac, animated: true)
        }
        
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    func resetGame(action: UIAlertAction) {
        questions.shuffle()
        level = 0
        tries = 2
        currentAnswer.text = String(repeating: "_ ", count: questions[level].count)
        for button in activatedButtons {
            button.isHidden = false
        }
        correctGuesses.removeAll()
    }
}

