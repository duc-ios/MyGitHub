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
    case users(perPage: Int, since: Int)
}

// MARK: TargetType

extension GitHubService: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .users:
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
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
