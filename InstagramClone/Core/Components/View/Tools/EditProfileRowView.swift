//
//  EditProfileRowView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/14/24.
//

import SwiftUI

struct EditProfileRowView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 100, alignment: .leading)
                .padding(.horizontal, 10)
                .fontWeight(.semibold)
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 40)
        
    }
}
