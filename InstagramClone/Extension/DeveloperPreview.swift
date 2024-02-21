//
//  DeveloperPreview.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/16/24.
//

import SwiftUI
import Firebase

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let comment = Comment(
        postsId: "123",
        postOwnerUid: "321",
        commentOwnerUid: "1234324532",
        commentText: "This is a comment for the preview ONLY",
        timestamp: Timestamp())
    
    let notifications: [Notification] = [
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), type: .like, notificationSenderUid: "123") ,
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), type: .comment, notificationSenderUid: "124") ,
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), type: .follow, notificationSenderUid: "125") ,
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), type: .like, notificationSenderUid: "126")
    ]
}

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

