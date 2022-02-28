//
//  ReminderList+CoreDataProperties.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/02/28.
//
//

import Foundation
import CoreData


extension ReminderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderList> {
        return NSFetchRequest<ReminderList>(entityName: "ReminderList")
    }

    @NSManaged public var title: String
    @NSManaged public var reminders: Array<Reminder>
    
    
    static func create(withTitle title: String,
                       in context: NSManagedObjectContext) {
        let newReminderList = ReminderList(context: context)
        newReminderList.title = title
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
                       
                                        
}

extension ReminderList : Identifiable {

}
