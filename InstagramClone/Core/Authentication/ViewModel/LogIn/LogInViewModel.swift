//
//  LogInViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/13/24.
//

import Foundation

class LogInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func logIn() async throws {
        try await AuthService.shared.logIn(withEmail: email, password: password)
    }
}
