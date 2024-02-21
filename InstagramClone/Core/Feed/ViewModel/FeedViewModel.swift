//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task {
            try await fetchPosts() 
        }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPost()
    }
}
