//
//  TabBarView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct TabBarView: View {
    let user: User
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            FeedView()
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
            SearchView()
                .tag(1)
                .tabItem { 
                    Image(systemName: "magnifyingglass")
                }
            UploadPostView(selection: $selection)
                .tag(2)
                .tabItem {
                    Image(systemName: "plus.app")
                }
            NotificationsView()
                .tag(3)
                .tabItem {
                    Image(systemName: "heart")
                }
            CurrentProfileView(user: user)
                .tag(4)
                .tabItem {
                    Image(systemName: "person")
                }
        }
        //accentColor only -> TABVIEW
        .accentColor(.black)
    }
}

#Preview {
    TabBarView(user: User.MOCK_USERS[0])
}
