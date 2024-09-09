//
//  UserModel.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import SwiftData

// MARK: - UserModel

@Model
final class UserModel {
    @Attribute(.unique) var id: Int
    var login: String
    var avatarUrl: String?
    var gravatarId: String?
    var htmlUrl: String
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var reposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var bio: String?
    var twitterUsername: String?
    var publicRepos: Int = 0
    var publicGists: Int = 0
    var followers: Int = 0
    var following: Int = 0

    init(
        id: Int = 0,
        login: String = "",
        htmlUrl: String = "",
        avatarUrl: String? = nil
    ) {
        self.id = id
        self.login = login
        self.htmlUrl = htmlUrl
        self.avatarUrl = avatarUrl
    }
}

// MARK: Codable

extension UserModel: Codable {
    enum CodingKeys: CodingKey {
        case id,
             login,
             avatarUrl,
             gravatarId,
             htmlUrl,
             followersUrl,
             followingUrl,
             gistsUrl,
             starredUrl,
             subscriptionsUrl,
             organizationsUrl,
             reposUrl,
             eventsUrl,
             receivedEventsUrl,
             name,
             company,
             blog,
             location,
             email,
             bio,
             twitterUsername,
             publicRepos,
             publicGists,
             followers,
             following
    }

    convenience init(from decoder: any Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        followersUrl = try container.decodeIfPresent(String.self, forKey: .followersUrl)
        followingUrl = try container.decodeIfPresent(String.self, forKey: .followingUrl)
        gistsUrl = try container.decodeIfPresent(String.self, forKey: .gistsUrl)
        starredUrl = try container.decodeIfPresent(String.self, forKey: .starredUrl)
        subscriptionsUrl = try container.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        organizationsUrl = try container.decodeIfPresent(String.self, forKey: .organizationsUrl)
        reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl)
        eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl)
        receivedEventsUrl = try container.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        company = try container.decodeIfPresent(String.self, forKey: .company)
        blog = try container.decodeIfPresent(String.self, forKey: .blog)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        publicRepos = try container.decodeIfPresent(Int.self, forKey: .publicRepos) ?? 0
        publicGists = try container.decodeIfPresent(Int.self, forKey: .publicGists) ?? 0
        followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
        following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(gravatarId, forKey: .gravatarId)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(followersUrl, forKey: .followersUrl)
        try container.encode(followingUrl, forKey: .followingUrl)
        try container.encode(gistsUrl, forKey: .gistsUrl)
        try container.encode(starredUrl, forKey: .starredUrl)
        try container.encode(subscriptionsUrl, forKey: .subscriptionsUrl)
        try container.encode(organizationsUrl, forKey: .organizationsUrl)
        try container.encode(reposUrl, forKey: .reposUrl)
        try container.encode(eventsUrl, forKey: .eventsUrl)
        try container.encode(receivedEventsUrl, forKey: .receivedEventsUrl)
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
        try container.encode(blog, forKey: .blog)
        try container.encode(location, forKey: .location)
        try container.encode(email, forKey: .email)
        try container.encode(bio, forKey: .bio)
        try container.encode(twitterUsername, forKey: .twitterUsername)
        try container.encode(publicRepos, forKey: .publicRepos)
        try container.encode(publicGists, forKey: .publicGists)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
    }
}
