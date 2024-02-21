//
//  FeedView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var showComments = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.posts) { post in
                        FeedRowView(post: post)
                    }
                }
                .padding(.top, 10)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        //
                    }, label: {
                        Image(systemName: "paperplane")
                            .foregroundColor(.black)
                            .imageScale(.large)
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Image("img-instagram")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 30)
                            .background(Color.white)
                    })
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeedView()
}
