//
//  Note.swift
//  Milestone8
//
//  Created by Alexander Tu on 03.12.19.
//  Copyright © 2019 Alexander Tu. All rights reserved.
//

import Foundation

struct Note: Equatable, Codable {
    var id: UUID
    var text: String
    //var title: String
    
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}
