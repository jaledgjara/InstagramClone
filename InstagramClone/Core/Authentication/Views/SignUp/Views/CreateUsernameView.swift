//
//  CreateUsernameView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import SwiftUI

struct CreateUsernameView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create username")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Pick a username for your new account. You can always change it later")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            TextField("Username", text: $viewModel.username)
                .modifier(InputRowModifier())
            
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
}
