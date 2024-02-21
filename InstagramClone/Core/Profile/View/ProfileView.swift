//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    //header
                    ProfileHeaderView(user: user)
                    //post grid
                    PostGridView(user: user)
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
