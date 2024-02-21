//
//  Comment.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Comment: Codable, Identifiable {
    @DocumentID var commentId: String?
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
    let postsId: String
    let postOwnerUid: String
    let commentOwnerUid: String
    let commentText: String
    let timestamp: Timestamp
    
    var user: User?
}
