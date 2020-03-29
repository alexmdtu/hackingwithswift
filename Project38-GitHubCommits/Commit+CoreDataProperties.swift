//
//  Commit+CoreDataProperties.swift
//  Project38-GitHubCommits
//
//  Created by Alexander Tu on 29.03.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String

}
