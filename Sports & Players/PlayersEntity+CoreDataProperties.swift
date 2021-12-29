//
//  PlayersEntity+CoreDataProperties.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//
//

import Foundation
import CoreData


extension PlayersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayersEntity> {
        return NSFetchRequest<PlayersEntity>(entityName: "PlayersEntity")
    }

    @NSManaged public var playerAge: Int16
    @NSManaged public var playerHeight: Float
    @NSManaged public var playerName: String?
    @NSManaged public var sportRelated: SportsEntity?

}

extension PlayersEntity : Identifiable {

}
