//
//  InputRowItem.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import Foundation
import SwiftUI

struct InputRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .font(.subheadline)
            .padding()
            .frame(width: UIScreen.main.bounds.width - 50,
                   height: 40,
                   alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}
