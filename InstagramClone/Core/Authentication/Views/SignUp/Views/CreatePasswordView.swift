//
//  CreatePasswordView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a password")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your password must be at least 6 characters in length")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            SecureField("Password", text: $viewModel.password)
                .modifier(InputRowModifier())
            
            //Button
            NavigationLink {
                CompleteSignUpView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .frame(width: UIScreen.main.bounds.width - 35, height: 40, alignment: .center)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .cornerRadius(5)
            }

            Spacer()
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
    CreatePasswordView()
}
