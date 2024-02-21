//
//  Notification.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import Foundation
import Firebase

struct Notification: Identifiable, Codable {
    let id: String
    let timestamp: Timestamp
    let type: NotificationType
    let notificationSenderUid: String
    var postId: String?
    
    var user: User?
    var post: Post?
}
