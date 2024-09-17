//
//  Route.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Routing
import SwiftUI

enum Route: Routable {
    case users([UserModel]),
         userDetails(UserModel)

    @ViewBuilder
    func viewToDisplay(router: Router<Route>) -> some View {
        Group {
            switch self {
            case .users(let users):
                UsersView()
                    .configured(users: users)
            case .userDetails(let user):
                UserDetailsView()
                    .configured(user: user)
            }
        }
        .environmentObject(router)
    }

    var navigationType: NavigationType {
        switch self {
        case .users: .push
        case .userDetails: .push
        }
    }
}
