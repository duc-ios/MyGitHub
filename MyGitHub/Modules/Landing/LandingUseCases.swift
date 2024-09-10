//
//  LandingUseCases.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation

// swiftlint:disable nesting
enum Landing {
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

    enum LoadFirstPageUsers {
        struct Request {
            var since: Int
        }

        struct Response {
            var users: [UserModel]
        }
    }
}

// swiftlint:enable nesting
