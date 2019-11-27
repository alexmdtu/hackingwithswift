//
//  ViewController.swift
//  Project2
//
//  Created by Alexander Tu on 19.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                highScore = try jsonDecoder.decode(Int.self, from: savedPeople)
            } catch {
                print("Failed to load high score")
            }
        }
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = "Current score: \(score) Q: \(countries[correctAnswer].uppercased())"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // animate button taps
        UIButton.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            sender.transform = .identity
        }, completion: nil)
        
        // handle correct and incorrect answers
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[correctAnswer].uppercased())"
            score -= 1
        }
        
        questionsAnswered += 1
        if questionsAnswered == 5 {
            if score > highScore {
                highScore = score
                save()
                message = "Your final score is \(score), you have beaten your old record!"
            } else {
                message = "Your final score is \(score). Try again to beat your high score of \(highScore)"
                
            }
            
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        } else {
            message = "Your score is \(score)."
        }
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current score", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(highScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highScore")
        } else {
            print("Failed to save high score.")
        }
    }
}

