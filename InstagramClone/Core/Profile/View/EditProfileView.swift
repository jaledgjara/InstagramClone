//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/14/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @StateObject var viewModel: EditProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            
            //toolbar
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button(action: {
                    Task {
                        try await viewModel.updateUserData()
                        dismiss()
                    }
                }, label: {
                    Text("Done")
                        .fontWeight(.semibold)
                })
            }
            .padding(.horizontal)
            
            Divider()
            
            //image picker
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack(spacing: 10) {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80, alignment: .center)
                            .clipShape(.circle)
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }
                    
                    Button(action: {
                        //
                    }, label: {
                        Text("Edit profile picture")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    })
                }
                .padding(.vertical)
            }
            
            Divider()
            
            //textfield
            VStack {
                EditProfileRowView(text: $viewModel.fullname, title: "Name", placeholder: "Name...")
                EditProfileRowView(text: $viewModel.bio, title: "Bio", placeholder: "Bio...")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
