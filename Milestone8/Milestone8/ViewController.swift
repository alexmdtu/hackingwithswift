//
//  ViewController.swift
//  Milestone8
//
//  Created by Alexander Tu on 02.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Notes"
        
        // todo: add toolbar instead of bar button items, see https://developer.apple.com/documentation/uikit/uitoolbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNote))
        
        // load notes from user defaults
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load notes")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // send stored note info
            vc.noteText = notes[indexPath.row].text
            vc.noteId = notes[indexPath.row].id
            vc.index = indexPath.row
            vc.delegate = self
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func createNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // create new id for new note
            vc.noteId = UUID()
            vc.delegate = self
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveNote(id: UUID, text: String, index: Int) {
        let newNote = Note(id: id, text: text)
        
        if notes.contains(newNote) {
            // editing old note
            notes[index].text = text
        } else {
            // create new note
            notes.append(newNote)
        }
        save()
        tableView.reloadData()
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
}

