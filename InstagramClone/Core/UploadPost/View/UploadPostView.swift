//
//  UploadPostView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var textCaption: String = ""
    @State private var imagePickerPresented: Bool = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var selection: Int
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            //ACTION TOOL BAR
            HStack {
                //button1
                Button(action: {
                    clearAndReturn()
                }, label: {
                    Text("Cancel")
                })
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                //button2
                Spacer()
                Button(action: {
                    Task {
                        try await viewModel.uploadPost(caption:textCaption)
                        clearAndReturn()
                    }
                }, label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                })
            }.padding(.horizontal)
            //POST IMAGE AND CAPTION
            HStack(spacing: 10) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                    
                
                TextField("Introduce your caption...", text: $textCaption, axis: .vertical)
            }
            .padding()
            .onAppear() {
                imagePickerPresented.toggle()
            }
            .photosPicker(
                isPresented: $imagePickerPresented,
                selection: $viewModel.selectedImage
            )
            
            Spacer()
        }
    }
    
    func clearAndReturn() {
        textCaption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        selection = 0
    }
}

#Preview {
    UploadPostView(selection: .constant(0))
}
