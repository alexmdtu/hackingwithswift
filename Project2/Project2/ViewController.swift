//
//  ViewController.swift
//  Project2
//
//  Created by Alexander Tu on 19.09.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
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
        
        // notification setup
        registerLocal()
        scheduleLocal()
        
        // regular app behavior
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
    
    // notification related functions
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
                
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Play game!"
        content.body = "Let's play a bit more today!"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
                
        // interval trigger for each day
        let dayInSeconds: TimeInterval = 86400
        
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: dayInSeconds, repeats: false)
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: dayInSeconds*2, repeats: false)
        let trigger3 = UNTimeIntervalNotificationTrigger(timeInterval: dayInSeconds*3, repeats: false)
        let trigger4 = UNTimeIntervalNotificationTrigger(timeInterval: dayInSeconds*4, repeats: false)

        let request1 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger1)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
        let request3 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger3)
        let request4 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger4)
        
        center.add(request1)
        center.add(request2)
        center.add(request3)
        center.add(request4)
        }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Play some flag games!", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")
        case "show":
            // the user tapped our "show more info…" button
            print("return to game")
        default:
            break
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
}

