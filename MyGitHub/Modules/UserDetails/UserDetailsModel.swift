//
//  UserDetailsModel.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation

// swiftlint:disable nesting
enum UserDetails {
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

    enum GetUserDetails {
        struct Request {
            var login: String
        }

        struct Response {
            var user: UserModel
        }
    }
}

// swiftlint:enable nesting
