//
//  FeedRowView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI
import Kingfisher

struct FeedRowView: View {
    @ObservedObject var viewModel: FeedRowModelView
    @State private var showComments = false
    private var post: Post {
        return viewModel.post
    }
    
    private var didLike: Bool {
        return post.didLike ?? false
    }
    
    init(post: Post) {
        self.viewModel = FeedRowModelView(post: post)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            //profile img + name
            HStack(spacing: 10) {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xsmall)
                    
                    
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
        
        //image posted
            KFImage(URL(string: post.imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .cornerRadius(5)
        
        
        //like/comment/share
        HStack(spacing: 20) {
            Button(action: {
                handleLikeTapped()
            }, label: {
                Image(systemName: didLike ? "heart.fill" : "heart")
                    .foregroundStyle(didLike ? .red : .black)
                
            })
            
            Button(action: {
                showComments.toggle()
            }, label: {
                Image(systemName: "bubble")
            })
            
            Button(action: {
                //
            }, label: {
                Image(systemName: "paperplane")
            })
            
            Spacer()
        }
        .imageScale(.large)
        .foregroundStyle(.black)
        .padding(.horizontal)
        
        VStack(alignment: .leading, spacing: 5) {
            //like label
            if post.likes > 0 {
                Text("\(post.likes) likes")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            
            //username + bio
            HStack() {
                Text(post.user?.username ?? "")
                    .fontWeight(.semibold)
                Text(post.caption)
                
                Spacer()
            }
            .font(.footnote)
            
            //time ago posted
            Text(post.timestamp.timestampString())
                .font(.caption)
                .foregroundStyle(Color(.systemGray))
        }
        .padding(.leading, 10)
        .padding(.vertical)
        }.sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
        })
    }
    
    
    func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}


#Preview {
    FeedRowView(post: Post.MOCK_POSTS[0])
}
