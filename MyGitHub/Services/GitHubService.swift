//
//  GitHubService.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation
import Moya

// MARK: - GitHubService

enum GitHubService {
    case users(perPage: Int, since: Int),
         user(String)
}

// MARK: TargetType

extension GitHubService: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .users:
            return "/users"
        case let .user(login):
            return "/users/\(login)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .users,
             .user:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .users(perPage, since):
            return .requestParameters(parameters: [
                "per_page": perPage,
                "since": since
            ], encoding: URLEncoding.queryString)
        case .user:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json;charset=utf-8"]
    }
}
