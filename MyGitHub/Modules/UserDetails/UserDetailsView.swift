//
//  UserDetailsView.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftData
import SwiftUI

// MARK: - UserDetailEvent

enum UserDetailEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             user(UserModel)
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
        VStack(spacing: 24) {
            if store.isLoading {
                ProgressView().scaleEffect(x: 2, y: 2)
            } else {
                UserDetailsHeader(
                    avatarUrl: store.avatarUrl,
                    login: store.login,
                    location: store.location
                )
            }

            HStack {
                RoundButton(iconName: "person.2.fill", total: store.followers > 100 ? "100+" : "\(store.followers)", title: store.followers == 1 ? "Follower" : "Followers")

                RoundButton(iconName: "figure.walk", total: store.following > 100 ? "100+" : "\(store.following)", title: store.following == 1 ? "Following" : "Followings")
            }

            VStack(alignment: .leading) {
                Text("Blog").font(.title3).bold()
                Text(store.blog)
                    .foregroundStyle(Color(.systemGray))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("User Details")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button("OK") {} },
               message: { Text(store.alertMessage) })
        .onAppear {
            interactor.getUserDetails(request: .init(login: store.login))
        }
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
    return UserDetailsView().configured(login: "login")
}
#endif
