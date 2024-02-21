//
//  ContentView.swift
//  InstagramClone
//
//  Created by Jaled Jara on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LogInView()
                    .environmentObject(signUpViewModel)
            } else if let currentUser = viewModel.currentUser {
                TabBarView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
