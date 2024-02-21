//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/20/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            NavigationLink(value: notification.user) {
                CircularProfileImageView(user: notification.user, size: .xsmall)
            }
            
            HStack(alignment: .bottom, spacing: 2) {
                Text(notification.user?.username ?? "")
                    .fontWeight(.semibold)
                +
                
                Text(" \(notification.type.notificationMessage)")
                    +
                
                Text("\(notification.timestamp.timestampString())")
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .font(.subheadline)
            
            Spacer()
            
            if notification.type != .follow {
                NavigationLink(value: notification.post) {
                    KFImage(URL(string: notification.post?.imageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(.trailing)
                }
            } else {
                Button(action: {
                    print("DEBUG: Follow here")
                }, label: {
                    Text("follow")
                        .frame(width: 85, height: 35)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .background(Color(.systemBlue))
                        .fontWeight(.semibold)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .padding()
                })
            }
        }
    }
}

#Preview {
    NotificationCell(notification: DeveloperPreview.shared.notifications[1])
}
