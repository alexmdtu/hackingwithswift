//
//  Whistle.swift
//  Project33
//
//  Created by Alexander Tu on 18.02.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
