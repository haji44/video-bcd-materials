//
//  ReminderListView.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/02/28.
//

import SwiftUI
extension Color {
  static var random: Color {
    return Color(red: Double.random(in: 0...1),
                 green: Double.random(in: 0...1),
                 blue: Double.random(in: 0...1))
  }
}



struct ReminderListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var reminders: FetchedResults<ReminderList>
    
    var body: some View {
        VStack {
            List(reminders, id: \.self) { reminderList in
                NavigationLink {
                    RemindersView(reminderList: reminderList)
                } label: {
                    CircularImageView(color: Color.random)
                    Text(reminderList.title)
                }
            }
                
        }//: VSTACK
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
