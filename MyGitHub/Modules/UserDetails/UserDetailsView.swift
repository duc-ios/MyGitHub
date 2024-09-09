//
//  UserDetailsView.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

// MARK: - UserDetailEvent

enum UserDetailEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError)
    }

    case view(View)
}

// MARK: - UserDetailsDisplayLogic

protocol UserDetailsDisplayLogic {
    var event: UserDetailEvent? { get set }
}

// MARK: - UserDetailsView

struct UserDetailsView: View {
    var interactor: UserDetailsBusinessLogic!
    @ObservedObject var store = UserDetailsDataStore()
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Text("UserDetails")
        }
        .navigationTitle("UserDetails")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button("OK") {} },
               message: { Text(store.alertMessage) })
    }
}

#if DEBUG
#Preview {
    UserDetailsView().configured(user: UserModel(id: 0, login: "User"))
}
#endif
