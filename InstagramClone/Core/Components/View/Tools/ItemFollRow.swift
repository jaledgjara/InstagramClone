//
//  ItemFollRow.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct ItemFollRow: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
        .opacity(value == 0 ? 0.5 : 1.0 )
    }
}

#Preview {
    ItemFollRow(value: 19, title: "followers")
}
