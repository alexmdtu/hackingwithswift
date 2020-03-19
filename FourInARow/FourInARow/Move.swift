//
//  Move.swift
//  FourInARow
//
//  Created by Alexander Tu on 19.03.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

import GameplayKit
import UIKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int

    init(column: Int) {
        self.column = column
    }
}
