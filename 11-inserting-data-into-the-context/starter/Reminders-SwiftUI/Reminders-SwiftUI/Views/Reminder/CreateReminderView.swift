

import SwiftUI
import CoreData

enum ReminderPriority: Int16, CaseIterable {
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
}

extension ReminderPriority {
    var shortDisplay: String {
        switch self {
        case .none: return ""
        case .low: return "!"
        case .medium: return "!!"
        case .high: return "!!!"
        }
    }
    
    var fullDisplay: String {
        switch self {
        case .none: return "None"
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
}

struct CreateReminderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    let reminderList: ReminderList
    // MARK: - State -
    @State var text: String = ""
    @State var notes: String = ""
    @State var shouldRemind: Bool = false
    @State var dueDate = Date()
    @State var priority: ReminderPriority = .none

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $text)
                    TextField("Notes", text: $notes)
                }
                Section {
                    HStack {
                        Toggle(isOn: $shouldRemind) {
                            Text("Remind me")
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                        }
                    }
                    if shouldRemind {
                        DatePicker(selection: $dueDate, displayedComponents: .date) {
                            Text("Date")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: ReminderPrioritySelectionView(priority: $priority)) {
                        Text("Priority")
                        Spacer()
                        Text(priority.fullDisplay)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle(Text("Create Event"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                Reminder.createWith(title: text,
                                    notes: notes,
                                    date: dueDate,
                                    priority: priority,
                                    in: reminderList,
                                    using: viewContext)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .fontWeight(.bold)
            }
            )
        }
    }
}

struct CreateReminderView_Previews: PreviewProvider {
    static var previews: some View {
        let container = NSPersistentContainer(name: "Reminders")
        container.loadPersistentStores { description, error in
            
        }
        let context = container.viewContext
        let newReminderList = ReminderList(context: context)
        newReminderList.title = "Test list"
        return CreateReminderView(reminderList: newReminderList).environment(\.managedObjectContext, context)
    }
}
