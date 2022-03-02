/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import CoreData

struct RemindersView: View {
    @State var isShowingCreateModal: Bool = false
    @State var isShowingTagModal: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    var fetchRequest: FetchRequest<Reminder>
    var reminders: FetchedResults<Reminder> {
        fetchRequest.wrappedValue
    }
    let reminderList: ReminderList
    
    var tags: Array<Tag> {
        let tagsSet = reminderList.reminders.compactMap( {$0.tags })
            .reduce(Set<Tag>()) { (result, tags) in
                var result = result
                result.formUnion(tags)
                return result
        }
        return Array(tagsSet)
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(reminders, id: \.self) { reminder in
                        ReminderRow(reminder: reminder)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
            HStack {
                NewReminderButtonView(isShowingCreateModal: $isShowingCreateModal, reminderList: reminderList)
                Spacer()
            }
            .padding(.leading)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingTagModal = true
                    } label: {
                        Text("Tags")
//
                    }
                    .sheet(isPresented: $isShowingTagModal) {
                        TagListView(tags: tags).environment(\.managedObjectContext, self.viewContext)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Reminders"))
    }
    init(reminderList: ReminderList) {
        self.reminderList = reminderList
        fetchRequest = Reminder.reminders(in: reminderList)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        let container = NSPersistentContainer(name: "Reminders")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        let context = container.viewContext
        let newReminderList = ReminderList(context: context)
        newReminderList.title = "Preview List"
        return RemindersView(reminderList: newReminderList).environment(\.managedObjectContext, context)
    }
}
