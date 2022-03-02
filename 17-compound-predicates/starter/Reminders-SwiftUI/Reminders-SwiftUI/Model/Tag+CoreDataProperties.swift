//
//  Tag+CoreDataProperties.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/03/01.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var title: String?
   
    // インプットをタグに保存する
    /// 入力後追加ボタンをタップで保存
    static func save(title: String, with viewContext : NSManagedObjectContext) {
        let newTag = Tag(context: viewContext)
        newTag.title = title
        do {
            try viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("\(nserror), \(nserror.userInfo)")
        }
    }
}



extension Tag : Identifiable {

}
