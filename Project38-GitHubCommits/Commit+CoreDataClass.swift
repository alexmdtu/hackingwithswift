//
//  Commit+CoreDataClass.swift
//  Project38-GitHubCommits
//
//  Created by Alexander Tu on 29.03.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }
}
