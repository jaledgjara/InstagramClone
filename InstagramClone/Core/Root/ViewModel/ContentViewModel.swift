//
//  ContentViewModel.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/9/24.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setUpSubscribers()
    }
    
    func setUpSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
        
        UserService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellables)
    }
    
}

