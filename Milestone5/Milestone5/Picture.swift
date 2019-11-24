//
//  Picture.swift
//  Milestone5
//
//  Created by Alexander Tu on 24.11.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
