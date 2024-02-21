//
//  ImageUploaderService.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/14/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

struct ImageUploaderService {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profiles_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Image upload error \(error.localizedDescription)")
            return nil
        }
    }
}
