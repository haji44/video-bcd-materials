//
//  TagListView.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/03/03.
//

import SwiftUI
import CoreData

struct TagListView: View {
    let tags: Array<Tag>
    var body: some View {
        NavigationView {
            VStack {
                List(tags, id: \.self) { tag in
                    Text("\(tag.title) (\(tag.reminderCount))")
                }
            }
            .navigationTitle("Tag")
        }
    }
}

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        let container = NSPersistentContainer(name: "Reminders")
        container.loadPersistentStores { descriptor, error in
            if let nserror = error as NSError? {
                fatalError("\(nserror)")
            }
        }
        let context = container.viewContext
        let tag = Tag(context: context)
        tag.title = "Test Tag"

        return TagListView(tags: [tag]).environment(\.managedObjectContext, context)
    }
}
