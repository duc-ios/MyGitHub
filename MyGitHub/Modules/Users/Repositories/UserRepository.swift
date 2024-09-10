//
//  UserRepository.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation
import Moya

// MARK: - UserRepository

protocol UserRepository {
    /// Fetches a list of GitHub users starting from the specified `since` ID.
    ///
    /// - Parameter since: The user ID to start fetching from (used for pagination).
    /// - Returns: An array of `UserModel` objects representing GitHub users.
    /// - Throws: An error if the network request fails or data parsing encounters an issue.
    /// - Note: This function is asynchronous and should be called with `await`.
    ///
    /// Example:
    /// ```swift
    /// let users = try await getUsers(since: 100)
    /// ```
    func getUsers(since: Int) async throws -> [UserModel]
    
    /// Fetches detailed information for a specific GitHub user by their login (username).
    ///
    /// - Parameter login: The GitHub username for the user whose details are being fetched.
    /// - Returns: A `UserModel` object representing the user's profile and details.
    /// - Throws: An error if the network request fails, the user does not exist, or data parsing encounters an issue.
    /// - Note: This function is asynchronous and should be called with `await`.
    ///
    /// Example:
    /// ```swift
    /// let user = try await getUser(login: "octocat")
    /// ```
    func getUser(login: String) async throws -> UserModel
}

// MARK: - UserRepositoryImp

class UserRepositoryImp: UserRepository {
    private let provider = MoyaProvider<GitHubService>(plugins: [VerbosePlugin(verbose: true)])
    
    func getUsers(since: Int) async throws -> [UserModel] {
        try await provider.async.request(.users(perPage: Constants.perPage, since: since))
    }
    
    func getUser(login: String) async throws -> UserModel {
        try await provider.async.request(.user(login))
    }
}
