//
//  Picture.swift
//  Project1
//
//  Created by Alexander Tu on 24.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
    var image: String
    var count: Int
    
    init(image: String, count: Int) {
        self.image = image
        self.count = count
    }
}
