//
//  ViewController.swift
//  Project28
//
//  Created by Alexander Tu on 05.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
        
        title = "Nothing to see here"
        
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"

        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Change password", style: .plain, target: self, action: #selector(setupPassword))
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }

        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        secret.scrollIndicatorInsets = secret.contentInset

        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    @IBAction func authenticateTapped(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        self?.authFailed()
                    }
                }
            }
        } else {
            // fallback if no biometrics available
            // check if password setup
            if let password = KeychainWrapper.standard.string(forKey: "Password") {
                let ac = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
                ac.addTextField()
                let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
                    guard let enteredPassword = ac?.textFields?[0].text else { return }
                    DispatchQueue.main.async {
                        if enteredPassword == password {
                            self?.unlockSecretMessage()
                        } else {
                            self?.authFailed()
                        }
                    }
                }
                ac.addAction(submitAction)
                present(ac, animated: true)
            } else {
                setupPassword()
                DispatchQueue.main.async {
                    self.unlockSecretMessage()
                }
            }
        }
    }
    
    @objc func setupPassword() {
        let ac = UIAlertController(title: "Setup password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let setupAction = UIAlertAction(title: "Setup", style: .default) { [weak ac] _ in
            guard let password = ac?.textFields?[0].text else { return }
            KeychainWrapper.standard.set(password, forKey: "Password")
        }
        ac.addAction(setupAction)
        present(ac, animated: true)
    }
    
    func authFailed() {
        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

