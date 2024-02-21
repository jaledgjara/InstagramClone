//
//  FeedRowModelView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation
import Firebase

@MainActor
class FeedRowModelView: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        
        Task {
            try await ifUserLikesThePost()
        }
    }
    
    func like() async throws {
        do {
            let postCopy = post
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(postCopy)
            
            NotificationManager.shared.uploadLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            let postCopy = post
            post.didLike = false
            post.likes -= 1
            try await PostService.unlikePost(postCopy)

            await NotificationManager.shared.deleteLikeNotification(notificationOwnerUid: post.ownerUid, post: post)
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func ifUserLikesThePost() async throws {
        self.post.didLike = try await PostService.ifUserLikesThePost(post)
    }
}
