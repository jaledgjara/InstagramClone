//
//  AuthService.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            //1) result
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            //2) userSessionResult
            self.userSession = result.user
            //3)loadUserData
            try await loadUserData()
        } catch {
            print("DEBUG: Failed sign in: \(error.localizedDescription)")
        }
    }
    

    func createUser(withEmail email: String, username: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Failed sign up: \(error.localizedDescription)")
        }
    }

    
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await UserService.shared.fetchCurrentUser()
    }
    

    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.currentUser = nil
    }
    

    func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, email: email, username: username)
        UserService.shared.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        try? await FirebaseConstants.UsersCollection.document(user.id).setData(encodedUser)
    }
}
