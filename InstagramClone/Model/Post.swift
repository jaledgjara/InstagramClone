//
//  Post.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import Foundation
import Firebase

struct Post: Identifiable, Codable, Hashable {
    
    let id: String
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    let imageUrl: String
    var likes: Int
    var user: User?
    
    var didLike: Bool? = false
}

extension Post {
    static var MOCK_POSTS : [Post] = [
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "This is the landscape for user 0",
            timestamp: Timestamp(),
            imageUrl: "img-0",
            likes: 1,
            user: User.MOCK_USERS[0]
        ),
        .init(
                id: UUID().uuidString,
                ownerUid: UUID().uuidString,
                caption: "This is the landscape for user 1",
                timestamp: Timestamp(),
                imageUrl: "img-1",
                likes: 22,
                user: User.MOCK_USERS[1]
        ),
        .init(
                id: UUID().uuidString,
                ownerUid: UUID().uuidString,
                caption: "This is the landscape for user 2",
                timestamp: Timestamp(),
                imageUrl: "img-2",
                likes: 333,
                user: User.MOCK_USERS[2]
        )
    ]
}
