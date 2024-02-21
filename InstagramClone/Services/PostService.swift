//
//  PostService.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation
import Firebase

struct PostService {
    
    private static let postsCollection = FirebaseConstants.PostsCollection
    private static let usersCollection = FirebaseConstants.UsersCollection
    
    static func fetchFeedPost() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerId = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerId)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPost(uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerId", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
    
    static func fetchPost(_ postId: String) async throws -> Post {
        return try await FirebaseConstants
            .PostsCollection
            .document(postId)
            .getDocument(as: Post.self)
    }
}


//MARK: - Likes

extension PostService {
    
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["likes":post.likes + 1])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-likes").document(uid).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["likes":post.likes - 1])
        async let _ = usersCollection.document(uid).collection("user-likes").document(uid).delete()
    }
    
    static func ifUserLikesThePost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await usersCollection.document(uid).collection("user-likes").document(post.id).getDocument()
        
        return snapshot.exists
    }
    
}
