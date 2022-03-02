//
//  TagView.swift
//  Reminders-SwiftUI
//
//  Created by kitano hajime on 2022/03/02.
//

import SwiftUI

struct TagView: View {
    let tags: Array<Tag>
    
    var body: some View {
        List(tags, id: \.self) { tag in
            Text(tag.title)
        }
    }
}
//
//struct TagView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagView(tags: <#[Tag]#>)
//    }
//}
