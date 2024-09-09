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
    func getUsers(since: Int) async throws -> [UserModel]
}

// MARK: - UserRepositoryImp

class UserRepositoryImp: UserRepository {
    private let provider = MoyaProvider<GitHubService>()
    
    func getUsers(since: Int) async throws -> [UserModel] {
        try await provider.async.request(.users(perPage: Constants.perPage, since: 0))
    }
}
