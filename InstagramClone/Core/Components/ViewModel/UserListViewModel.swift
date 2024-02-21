//
//  UserListViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/19/24.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
    }
    
    func fetchUsers(forList list: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forList: list)
        } catch {
            print(error.localizedDescription)
        }
    }
}
