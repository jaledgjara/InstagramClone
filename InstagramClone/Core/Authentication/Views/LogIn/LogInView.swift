//
//  LogInView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/8/24.
//

import SwiftUI

struct LogInView: View {
    @StateObject var viewModel = LogInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                //img-logo
                Image("img-instagram")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 125, height: 75, alignment: .center)
                    .padding()
                
                //text field * 2
                VStack(spacing: 15) {
                    TextField("Introduce your email", text: $viewModel.email)
                        .modifier(InputRowModifier())
                    SecureField("*******", text: $viewModel.password)
                        .modifier(InputRowModifier())
                }
                
                //forgot my pass
                Button(action: {
                    
                }, label: {
                    Text("Forgot Password?")
                        .padding()
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.trailing)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                //Button
                Button(action: {
                    Task {
                        try await viewModel.logIn()
                    }
                }, label: {
                    Text("Log In")
                        .frame(width: UIScreen.main.bounds.width - 35, height: 40, alignment: .center)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .cornerRadius(5)
                })
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        .foregroundStyle(.gray)
                    Text("OR")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical)
                
                //Facebook auth
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image("img-facebook")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                        Text("Continue with facebook")
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    
                })
                
                
                //divider
                Spacer()
                
                Divider()
                    .padding(.bottom)
                
                
                //sign up button
                NavigationLink {
                    AddYourEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 5) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                    .padding(.vertical)
                }
                
            }
        }
    }
}

#Preview {
    LogInView()
}

