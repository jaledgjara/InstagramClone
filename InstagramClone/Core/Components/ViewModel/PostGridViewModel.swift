//
//  PostGridViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserPosts()
        }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
