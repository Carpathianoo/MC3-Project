//
//  Compost+CoreDataProperties.swift
//  Komposku
//
//  Created by Clara Anggraini on 09/08/21.
//
//

import Foundation
import CoreData


extension Compost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Compost> {
        return NSFetchRequest<Compost>(entityName: "Compost")
    }

    @NSManaged public var estimated_date: Date?
    @NSManaged public var identifier: Int64
    @NSManaged public var moisture: Double
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var process: NSSet?
    @NSManaged public var latestProcess: Process?

}

// MARK: Generated accessors for process
extension Compost {

    @objc(addProcessObject:)
    @NSManaged public func addToProcess(_ value: Process)

    @objc(removeProcessObject:)
    @NSManaged public func removeFromProcess(_ value: Process)

    @objc(addProcess:)
    @NSManaged public func addToProcess(_ values: NSSet)

    @objc(removeProcess:)
    @NSManaged public func removeFromProcess(_ values: NSSet)

}

extension Compost : Identifiable {

}
