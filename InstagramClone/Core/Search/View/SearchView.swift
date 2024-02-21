//
//  SearchView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct SearchView: View {
    @State private var textSearch: String = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            UserListView(list: .explore)
                .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
                })
                .padding(.top)
                .searchable(text: $textSearch)
                .navigationTitle("Explore")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
