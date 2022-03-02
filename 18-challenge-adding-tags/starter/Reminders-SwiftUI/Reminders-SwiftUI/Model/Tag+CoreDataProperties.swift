//
//  Tag+CoreDataProperties.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/03/02.
//
//

import Foundation
import CoreData


extension Tag {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var reminders: Set<Reminder>
    
    static func fetchOrCreateWith( title: String, in context: NSManagedObjectContext) -> Tag {
        let request: NSFetchRequest<Tag> = fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", "title", title.lowercased())
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            
            if let tag = result.first {
                return tag
            } else {
                let tag = Tag(context: context)
                tag.title = title.lowercased()
                return tag
            }
        } catch {
            fatalError("error occuring")
        }
    }
    
    
}

extension Tag : Identifiable {
    
}
