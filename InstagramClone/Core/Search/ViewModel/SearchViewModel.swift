//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/14/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchAllUsers()
        }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users =  try await UserService.fetchAllUsers()
    }
}
