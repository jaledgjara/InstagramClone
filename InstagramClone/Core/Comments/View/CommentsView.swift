//
//  CommentsView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    @StateObject var viewModel: CommentViewModel
    
    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    var body: some View {
        VStack {
            Text("Comments")
                .font(.headline)
                .fontWeight(.semibold)
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
                Divider()
            HStack() {
                    CircularProfileImageView(user: currentUser ,size: .xsmall)
                    
                    HStack {
                        TextField("Add a comment for @charles_lecrerc",
                                  text: $commentText)
                        .font(.caption)
                        
                        Button(action: {
                            Task {
                                try await viewModel.uploadComment(commentText: commentText)
                                commentText = ""
                            }
                        }, label: {
                            Text("Post")
                                .foregroundStyle(.blue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        })
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 30)
                    .overlay {
                        Capsule()
                            .stroke(.gray, lineWidth: 0.5)
                    }
                }
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

#Preview {
    CommentsView(post: Post.MOCK_POSTS[0])
}
