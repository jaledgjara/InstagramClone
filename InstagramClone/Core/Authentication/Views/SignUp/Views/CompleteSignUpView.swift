//
//  CompleteSignUpView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Instagram, \(viewModel.username )")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Click below to complete registration and start using Instagram")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Button(action: {
                Task {
                    try await viewModel.createUser()
                }
            }, label: {
                Text("Complete Sign Up")
                    .frame(width: UIScreen.main.bounds.width - 35, height: 40, alignment: .center)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(5)
            })
        }
        .padding(.top, 50)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .imageScale(.large)
                    
                })
            }
        }
    }
}

#Preview {
    CompleteSignUpView()
}
