//
//  EditProfileViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/14/24.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task { await uploadImage(fromItem: selectedImage) }
        }
    }
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func uploadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        //dictionary data
        var data = [String: Any]()
        
        //Image
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploaderService.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        //username
        if !fullname.isEmpty && fullname != fullname {
            data["fullname"] = fullname
        }
        
        //bio
        if !bio.isEmpty && bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await FirebaseConstants.UsersCollection.document(user.id).updateData(data)
        }
    }
}
