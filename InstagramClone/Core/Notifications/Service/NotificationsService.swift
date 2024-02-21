//
//  NotificationsService.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import Firebase

class NotificationsService {
    init() {
    }
    
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirebaseConstants
            .UserNotificationCollection(uid: currentUid) //document for that user
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
    }
    
    func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else { return }
        let ref = FirebaseConstants
            .UserNotificationCollection(uid: uid)
            .document()
        
        let notification = Notification(id: ref.documentID,
                                        timestamp: Timestamp(),
                                        type: type,
                                        notificationSenderUid: currentUid,
                                        postId: post?.id)
        guard let notificationData = try? Firestore.Encoder().encode(notification) else { return }
        ref.setData(notificationData)
    }
    
    func deleteNotification(toUid uid: String, type: NotificationType, post: Post? = nil) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await FirebaseConstants
            .UserNotificationCollection(uid: uid)
            .whereField("notificationSenderUid", isEqualTo: currentUid)
            .getDocuments()
        
        let notifications = snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
        
        
        let filteredByType = notifications.filter({ $0.type == type }) //gets all notifications by types
        
        if type == .follow {
            for notification in filteredByType {//gets all notifications by types
                try await FirebaseConstants
                    .UserNotificationCollection(uid: uid)
                    .document(notification.id)
                    .delete()
            }
        } else {
            guard let notificationToDelete = filteredByType.first(where: { $0.postId == post?.id }) else { return }
            //get notifications for this post
            
            try await FirebaseConstants
                .UserNotificationCollection(uid: uid)
                .document(notificationToDelete.id)
                .delete()
        }
        
    }
}
