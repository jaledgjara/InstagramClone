//
//  AddYourEmailView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import SwiftUI

struct AddYourEmailView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add your email")
                .font(.title)
                .fontWeight(.bold)
            
            Text("You'll use this email to sign in, into your account")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            TextField("Introduce your email", text: $viewModel.email)
                .modifier(InputRowModifier())
            
            //Button
            NavigationLink {
                CreateUsernameView()
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
    AddYourEmailView()
}
