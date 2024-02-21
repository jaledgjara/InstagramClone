//
//  UserListView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/19/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel = UserListViewModel()
    @State private var textSearch = ""
    
    private var list: UserListConfig
    
    init(list: UserListConfig) {
        self.list = list
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        HStack(spacing: 10) {
                            CircularProfileImageView(user: user, size: .xsmall)
                            VStack {
                                Text(user.username)
                                    .fontWeight(.semibold)
                                Text(user.fullname ?? "")
                            }
                            .font(.subheadline)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .foregroundStyle(.black)
                    }
                }
            
            }
        }
        .task { await viewModel.fetchUsers(forList: list) }
        .padding(.top)
        .searchable(text: $textSearch)
    }
}

#Preview {
    UserListView(list: .explore)
}
