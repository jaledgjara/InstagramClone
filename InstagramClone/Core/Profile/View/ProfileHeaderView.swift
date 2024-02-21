//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var stats: UserStats {
        return user.stats ?? .init(followingCount: 0, followersCount: 0, postsCount: 0)
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var buttonBackground: Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            return Color(.systemBlue)
        }
    }
    
    private var buttonForeground: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    private var buttonStroke: Color {
        if user.isCurrentUser || isFollowed {
            return .gray
        } else {
            return .clear
        }
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
            //Row follow
        VStack {
            HStack(spacing: 30) {
                CircularProfileImageView(user: user, size: .large)
                
                HStack(spacing: 30) {
                    ItemFollRow(value: stats.postsCount, title: "post")
                    
                    NavigationLink(value: UserListConfig.followers(uid: user.id) ) {
                        ItemFollRow(value: stats.followersCount, title: "followers")
                    }
                    
                    
                    NavigationLink(value: UserListConfig.following(uid: user.id) ) {
                        ItemFollRow(value: stats.followingCount, title: "following")
                    }
                    
                }
                .padding(.horizontal)
                .foregroundStyle(.black)
            }
            .padding(.horizontal)
            
            //bio
            VStack(alignment: .leading) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            //Button edit profile
            VStack {
                Button(action: {
                    if user.isCurrentUser {
                        showEditProfile.toggle()
                    } else {
                        handleFollowTapped()
                    }
                    
                }, label: {
                    Text(buttonTitle)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 30)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .background(buttonBackground)
                        .foregroundStyle(buttonForeground)
                        .cornerRadius(7)
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(buttonStroke, lineWidth: 1)
                        }
                        .padding(.vertical)
                })
            }
            
            Divider()
        }
        .navigationDestination(for: UserListConfig.self, destination: { list in
            Text(list.navigationTitle)
        })
        .onAppear {
            viewModel.fetchUsersStats()
            viewModel.checkIfUserIsFollowed()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
