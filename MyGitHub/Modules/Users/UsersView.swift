//
//  UsersView.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import SwiftData
import SwiftUI

// MARK: - UsersEvent

enum UsersEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             users([UserModel])
    }

    case view(View)
}

// MARK: - UsersDisplayLogic

protocol UsersDisplayLogic {
    var event: UsersEvent? { get set }
}

// MARK: - UsersView

struct UsersView: View {
    var interactor: UsersBusinessLogic!
    @ObservedObject var store = UsersDataStore()
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]

    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink {
                    Text(user.login)
                } label: {
                    Text(user.login)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Users")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button("OK") {} },
               message: { Text(store.alertMessage) })
    }
}

#if DEBUG
#Preview {
    UsersView().configured()
}
#endif
