//
//  CurrentProfileView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import SwiftUI

struct CurrentProfileView: View {
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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            AuthService.shared.signOut()
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.black)
                                .imageScale(.large)
                        })
                    }
                }
            }
        }
    }
    
}


#Preview {
    CurrentProfileView(user: User.MOCK_USERS[0])
}
