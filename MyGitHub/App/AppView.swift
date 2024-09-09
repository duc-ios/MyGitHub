//
//  AppView.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import SwiftData
import SwiftUI

struct AppView: View {
    @ObservedObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            LandingView()
                .configured()
                .navigationDestination(for: Route.self) {
                    switch $0 {
                    case .users:
                        UsersView().configured()
                    case .userDetails(let user):
                        UserDetailsView().configured(user: user)
                    }
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    AppView()
        .modelContainer(for: UserModel.self, inMemory: true)
}
