//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation
import Firebase

@MainActor
class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
    private let service: CommentService
    private let post: Post
    
    init(post: Post) {
        self.post = post
        self.service = CommentService(postId: post.id)
        
        Task {
            try await fetchComments()
        }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let comment = Comment(postsId: post.id,
                              postOwnerUid: post.ownerUid,
                              commentOwnerUid: uid,
                              commentText: commentText,
                              timestamp: Timestamp())
        
        try await service.uploadComment(comment)
        try await fetchComments()
        
        NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
        
    }
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = user
        }
    }
}

