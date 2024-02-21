//
//  SignUpViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, username: username, password: password)
        
        email = ""
        username = ""
        password = ""
    }
}
