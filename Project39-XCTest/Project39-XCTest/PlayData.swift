//
//  PlayData.swift
//  Project39-XCTest
//
//  Created by Alexander Tu on 01.04.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import Foundation

class PlayData {
    var allWords = [String]()
    var wordCounts = [String: Int]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != "" }
                
                for word in allWords {
                    wordCounts[word, default: 0] += 1
                }
                allWords = Array(wordCounts.keys)
            }
        }
    }
}
