//
//  UsersView.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Routing
import SwiftData
import SwiftUI

// MARK: - UsersEvent

enum UsersEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             users(users: [UserModel], hasMore: Bool)
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
    @EnvironmentObject var router: Router<Route>

    var body: some View {
        List {
            ForEach(store.users) { user in
                UserCard(user: user) {
                    router.routeTo(.userDetails(user))
                }
            }

            if store.hasMore {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.black)
                    .foregroundColor(.red)
                    .onAppear {
                        interactor.loadUsers(request: .init(since: (store.users.last?.id ?? 0)))
                    }
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .navigationTitle("GitHub Users")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button("OK") {} },
               message: { Text(store.alertMessage) })
    }
}

#if DEBUG
#Preview {
    let schema = Schema([UserModel.self])
    let container = try! ModelContainer(
        for: schema,
        configurations:
        ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    )
    return RoutingView(Route.self) { router in
        UsersView()
            .configured(users: (1 ... 10).map {
                UserModel(
                    id: $0,
                    login: "mojombo",
                    htmlUrl: "https://github.com/mojombo",
                    avatarUrl: "https://avatars.githubusercontent.com/u/\($0)"
                )
            })
            .modelContainer(container)
            .environmentObject(router)
    }.tint(.primary)
}
#endif
