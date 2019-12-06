//
//  Person.swift
//  Project10
//
//  Created by Alexander Tu on 23.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
 
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
