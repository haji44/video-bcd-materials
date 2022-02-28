//
//  CircularImageView.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/02/28.
//

import SwiftUI

struct CircularImageView: View {
    var color: Color
    
    var body: some View {
      VStack {
        Image(systemName: "list.bullet")
          .foregroundColor(.white)
      }
      .padding(12)
      .background(color)
      .clipShape(Circle())
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(color: .red)
    }
}
