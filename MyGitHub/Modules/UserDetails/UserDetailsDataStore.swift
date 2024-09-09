//
//  UserDetailsDataStore.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Combine
import Foundation

// MARK: - UserDetailsDataStore

final class UserDetailsDataStore: BaseDataStore, UserDetailsDisplayLogic {
    // MARK: - Variables

    @Published var event: UserDetailEvent?

    var login: String!

    @Published var name: String = ""
    @Published var avatarUrl: String = ""
    @Published var location: String = ""
    @Published var followers: Int = 0
    @Published var following: Int = 0
    @Published var blog: String = ""

    // MARK: -

    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .compactMap {
                guard case .view(let event) = $0 else { return nil }
                return event
            }
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: UserDetailEvent.View) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case .user(let user):
            name = user.name ?? ""
            if let avatarUrl = user.avatarUrl {
                self.avatarUrl = avatarUrl
            } else if let gravatarId = user.gravatarId {
                avatarUrl = "http://www.gravatar.com/avatar/\(MD5(gravatarId))?s=100"
            }
            location = user.location ?? "N/A"
            followers = user.followers
            following = user.following
            blog = user.blog ?? "N/A"
        }
    }
}
