//
//  NotificationManager.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    private let service = NotificationsService()
    
    private init() {
        
    }
    
    func uploadLikeNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommentNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .comment, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(notificationOwnerUid: String, post: Post) async {
        do {
            try await service.deleteNotification(toUid: notificationOwnerUid, type: .like, post: post)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFollowNotification(notificationOwnerUid: String) async {
        do {
            try await service.deleteNotification(toUid: notificationOwnerUid, type: .follow)
        } catch {
            print(error.localizedDescription)
        }
    }
}
