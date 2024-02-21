//
//  User.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import Foundation
import Firebase

//Model Users
struct User: Hashable, Identifiable, Codable {
    let id: String
    let email: String
    var username: String
    var fullname: String?
    var profileImageUrl: String?
    var bio: String?
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var followersCount: Int
    var postsCount: Int
}

//Extension from users
extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: NSUUID().uuidString,
            email: "user0@gmail.com",
            username: "user0",
            fullname: "User 0",
            profileImageUrl: "profile-img-0",
            bio: "I'm the user 0"
        ),
        
        .init(
            id: NSUUID().uuidString,
            email: "user1@gmail.com",
            username: "user1",
            fullname: "User 1",
            profileImageUrl: "profile-img-1",
            bio: "I'm the user 0"
        ),
        
        .init(
            id: NSUUID().uuidString,
            email: "user2@gmail.com",
            username: "user2",
            fullname: "User 2",
            profileImageUrl: "profile-img-2",
            bio: "I'm the user 0"
             ),
        
        .init(
            id: NSUUID().uuidString,
            email: "user3@gmail.com",
            username: "user3",
            fullname: "User 3",
            profileImageUrl: "profile-img-3",
            bio: "I'm the user 0"
        )
    ]
}

