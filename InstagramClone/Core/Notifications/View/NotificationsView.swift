//
//  NotificationsView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var viewModel = NotificationViewModel(service: NotificationsService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
            .refreshable {
                Task { await viewModel.fetchNotifications() }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationDestination(for: Post.self, destination: { post in
                FeedRowView(post: post)
            })
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NotificationsView()
}
