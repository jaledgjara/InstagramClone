//
//  UserListConfig.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/19/24.
//

import Foundation


//hashable = navigatable
enum UserListConfig: Hashable {
    case followers(uid: String)  //followers of a particular account
    case following(uid: String) //following of a particular account
    case likes(postId: String) //likes related with a particular post
    case explore
    
    var navigationTitle: String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        case .likes: return "Likes"
        case .explore: return "Explore"
        }
    }
}
