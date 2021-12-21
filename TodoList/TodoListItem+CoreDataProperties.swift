//
//  TodoListItem+CoreDataProperties.swift
//  TodoList
//
//  Created by admin on 21/12/2021.
//
//

import Foundation
import CoreData


extension TodoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var taskDate: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskDone: Bool
    @NSManaged public var taskID: UUID?
    @NSManaged public var taskTitle: String?

}

extension TodoListItem : Identifiable {

}
