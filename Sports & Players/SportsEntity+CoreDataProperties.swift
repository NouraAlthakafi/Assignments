//
//  SportsEntity+CoreDataProperties.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//
//

import Foundation
import CoreData


extension SportsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SportsEntity> {
        return NSFetchRequest<SportsEntity>(entityName: "SportsEntity")
    }

    @NSManaged public var sportImage: Data?
    @NSManaged public var sportName: String?
    @NSManaged public var playerRelated: NSOrderedSet?

}

// MARK: Generated accessors for playerRelated
extension SportsEntity {

    @objc(insertObject:inPlayerRelatedAtIndex:)
    @NSManaged public func insertIntoPlayerRelated(_ value: PlayersEntity, at idx: Int)

    @objc(removeObjectFromPlayerRelatedAtIndex:)
    @NSManaged public func removeFromPlayerRelated(at idx: Int)

    @objc(insertPlayerRelated:atIndexes:)
    @NSManaged public func insertIntoPlayerRelated(_ values: [PlayersEntity], at indexes: NSIndexSet)

    @objc(removePlayerRelatedAtIndexes:)
    @NSManaged public func removeFromPlayerRelated(at indexes: NSIndexSet)

    @objc(replaceObjectInPlayerRelatedAtIndex:withObject:)
    @NSManaged public func replacePlayerRelated(at idx: Int, with value: PlayersEntity)

    @objc(replacePlayerRelatedAtIndexes:withPlayerRelated:)
    @NSManaged public func replacePlayerRelated(at indexes: NSIndexSet, with values: [PlayersEntity])

    @objc(addPlayerRelatedObject:)
    @NSManaged public func addToPlayerRelated(_ value: PlayersEntity)

    @objc(removePlayerRelatedObject:)
    @NSManaged public func removeFromPlayerRelated(_ value: PlayersEntity)

    @objc(addPlayerRelated:)
    @NSManaged public func addToPlayerRelated(_ values: NSOrderedSet)

    @objc(removePlayerRelated:)
    @NSManaged public func removeFromPlayerRelated(_ values: NSOrderedSet)

}

extension SportsEntity : Identifiable {

}
