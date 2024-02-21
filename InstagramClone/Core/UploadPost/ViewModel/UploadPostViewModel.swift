//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task { await uploadImage(fromItem: selectedImage) }
        }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func uploadImage(fromItem item: PhotosPickerItem?) async {
        //item check
        guard let item = item else { return }
        //Data transfer
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        //transform in uiImage
        guard let uiImage = UIImage(data: data) else { return }
        //cast into an Image
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        //check image and id
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        //get id, get image, post info, encode post
        let postRef = FirebaseConstants.PostsCollection.document()
        guard let imageUrl = try await ImageUploaderService.uploadImage(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, timestamp: Timestamp(), imageUrl: imageUrl, likes: 0)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        //final step
        try await postRef.setData(encodedPost)
    }
}
