//
//  NotificationType.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import Foundation

enum NotificationType: Int, Codable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "like one of your post"
        case .comment: return "commented on one of your posts"
        case .follow: return "started following you."
        }
    }
}
