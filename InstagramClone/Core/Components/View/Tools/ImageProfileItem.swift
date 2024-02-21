//
//  ImageProfileItem.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct ImageProfileItem: View {
    var body: some View {
        Image("profile-img-0")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    ImageProfileItem()
}
