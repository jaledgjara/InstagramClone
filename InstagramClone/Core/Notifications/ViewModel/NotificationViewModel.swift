//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    private let service: NotificationsService
    private let currentUser: User?
    
    init(service: NotificationsService) { //this viewModel has to init with this services
        self.service = service
        self.currentUser = UserService.shared.currentUser
        Task { await fetchNotifications() }
    }
    
    func fetchNotifications() async {
        do {
            self.notifications = try await service.fetchNotifications()
            try await updateNotifications()
        } catch {
            print("DEBUG: there is a problem fetching the notifications \(error.localizedDescription  )")
        }
    }
    
    private func updateNotifications() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            
            notification.user = try await UserService.fetchUser(withUid: notification.notificationSenderUid)
            
            if let postId = notification.postId {
                notification.post = try await PostService.fetchPost(postId)
                notification.post?.user = self.currentUser
            }
            
            notifications[i] = notification
        }
    }
}

/*
 dzapata
 
 */
