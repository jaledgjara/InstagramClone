//
//  CircularProfileImageView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/15/24.
//

import SwiftUI
import Kingfisher

enum ProfilImageSize {
    case xsmall
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .xsmall:
            return 40
        case .small:
            return 45
        case .medium:
            return 65
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
    let user: User?
    let size: ProfilImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
}
