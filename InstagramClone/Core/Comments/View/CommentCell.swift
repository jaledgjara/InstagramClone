//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import SwiftUI

struct CommentCell: View {
    let comment: Comment
    
    private var user: User? {
        return comment.user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            CircularProfileImageView(user: user, size: .xsmall)
            
            VStack(alignment: .leading) {
                HStack(spacing: 5){
                    Text(user?.username ?? "")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("6d")
                        .foregroundStyle(Color(.systemGray))
                        .font(.caption)
                    Spacer()
                }
                Text(comment.commentText)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}


