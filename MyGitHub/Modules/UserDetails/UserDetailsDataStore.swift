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

    var user: UserModel!

    @Published var avatarUrl: String = ""
    @Published var name: String = ""
    @Published var login: String = ""
    @Published var twitter: String = ""
    @Published var location: String = ""
    @Published var company: String = ""
    @Published var totalFollowers: String = ""
    @Published var totalFollowing: String = ""
    @Published var followers: String = ""
    @Published var following: String = ""
    @Published var blog: String = ""
    @Published var bio: String = ""

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
            if let avatarUrl = user.avatarUrl {
                self.avatarUrl = avatarUrl
            } else if let gravatarId = user.gravatarId {
                avatarUrl = "http://www.gravatar.com/avatar/\(MD5(gravatarId))?s=100"
            }
            name = user.name ?? ""
            login = user.login
            if let twitterUsername = user.twitterUsername {
                twitter = "@\(twitterUsername)"
            } else {
                twitter = "N/A"
            }
            location = user.location ?? "N/A"
            company = user.company ?? "N/A"
            totalFollowers = user.followers > 100 ? "100+" : "\(user.followers)"
            totalFollowing = user.following > 100 ? "100+" : "\(user.following)"
            followers = user.followers == 1 ? "Follower" : "Followers"
            following = user.following == 1 ? "Following" : "Followings"
            blog = user.blog ?? "N/A"
            bio = user.bio ?? "N/A"
        }
    }
}
