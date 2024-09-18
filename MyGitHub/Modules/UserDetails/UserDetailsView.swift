//
//  UserDetailsView.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftData
import SwiftUI

// MARK: - UserDetailsEvent

enum UserDetailsEvent: Equatable {
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
    var event: UserDetailsEvent? { get set }
}

// MARK: - UserDetailsView

struct UserDetailsView: View {
    var interactor: UserDetailsBusinessLogic!
    @ObservedObject var store = UserDetailsDataStore()
    @EnvironmentObject var router: Router

    var body: some View {
        List {
            Group {
                if store.isLoading {
                    ProgressView()
                        .scaleEffect(x: 2, y: 2)
                        .frame(maxWidth: .infinity)
                } else {
                    UserDetailsHeader(
                        avatarUrl: store.avatarUrl,
                        name: store.name,
                        login: store.login,
                        bio: store.bio
                    )
                }
            }
            .listRowSeparator(.hidden)

            HStack {
                Spacer()

                RoundButton(
                    iconName: "person.2.fill",
                    total: store.totalFollowers,
                    title: store.followers
                ) {
                    guard let followersUrl = store.user.followersUrl,
                          let url = URL(string: followersUrl)
                    else { return }
                    UIApplication.shared.open(url)
                }

                Spacer()

                RoundButton(
                    iconName: "figure.walk",
                    total: store.totalFollowing,
                    title: store.following
                ) {
                    guard let followingUrl = store.user.followingUrl,
                          let url = URL(string: followingUrl)
                    else { return }
                    UIApplication.shared.open(url)
                }

                Spacer()
            }
            .listRowSeparator(.hidden)
            .buttonStyle(PlainButtonStyle())

            DetailCard(icon: "mappin.and.ellipse",
                       title: "Location",
                       detail: store.location)

            DetailCard(icon: "suitcase",
                       title: "Company",
                       detail: store.company)

            DetailCard(icon: "bird",
                       title: "Twitter",
                       detail: store.twitter)

            DetailCard(icon: "pencil.and.scribble",
                       title: "Blog",
                       detail: store.blog)
        }
        .listStyle(.plain)
        .navigationTitle("User Details")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button("OK") {} },
               message: { Text(store.alertMessage) })
        .onAppear {
            interactor.getUserDetails(request: .init(login: store.user.login))
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
    return UserDetailsView()
        .configured(user: UserModel(login: "mojombo"))
        .modelContainer(container)
}
#endif
