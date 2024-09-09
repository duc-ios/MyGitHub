//
//  UsersModel.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation

// swiftlint:disable nesting
enum Users {
    enum ShowAlert {
        struct Request {
            var title: String
            var message: String
        }

        struct Response {
            var title: String
            var message: String
        }
    }

    enum ShowError {
        struct Request {
            var error: Error
        }

        struct Response {
            var error: AppError
        }
    }

    enum ShowUsers {
        struct Request {
            var users: [UserModel]
        }

        struct Response {
            var users: [UserModel]
        }
    }

    enum LoadUsers {
        struct Request {
            var since: Int
        }

        struct Response {
            var users: [UserModel]
            var hasMore: Bool
        }
    }
}

// swiftlint:enable nesting
