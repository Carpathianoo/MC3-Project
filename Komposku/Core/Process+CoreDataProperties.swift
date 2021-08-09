//
//  Process+CoreDataProperties.swift
//  Komposku
//
//  Created by Ahmad Zaky on 30/07/21.
//
//

import Foundation
import CoreData


extension Process {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Process> {
        return NSFetchRequest<Process>(entityName: "Process")
    }

    @NSManaged public var latestProcess: Process?
    @NSManaged public var date: Date?
    @NSManaged public var detail: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var isDone: Bool
    @NSManaged public var compost: Compost?

}

extension Process : Identifiable {

}
