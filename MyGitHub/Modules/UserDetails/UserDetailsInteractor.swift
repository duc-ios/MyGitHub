//
//  UserDetailsInteractor.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

// MARK: - UserDetailsBusinessLogic

protocol UserDetailsBusinessLogic {
    /// Updates the view to show or hide a loading indicator based on the `isLoading` flag.
    ///
    /// - Parameter isLoading: A boolean indicating whether the loading indicator should be shown (`true`) or hidden (`false`).
    ///
    /// Example:
    /// ```swift
    /// showLoading(isLoading: true)  // Display the loading indicator
    /// showLoading(isLoading: false) // Hide the loading indicator
    /// ```
    func showLoading(isLoading: Bool)

    /// Handles a request to display an error, typically triggered by a failure in loading data or user interaction issues.
    ///
    /// - Parameter request: A `UserDetails.ShowError.Request` object containing details about the error.
    ///
    /// Example:
    /// ```swift
    /// let errorRequest = UserDetails.ShowError.Request(error: AppError.notFound)
    /// showError(request: errorRequest)
    /// ```
    func showError(request: UserDetails.ShowError.Request)

    /// Handles the request to display a list of users in the view.
    ///
    /// - Parameter request: A `UserDetails.GetUserDetails.Request` object containing the data required to display users.
    ///
    /// Example:
    /// ```swift
    /// let showUsersRequest = UserDetails.GetUserDetails.Request(login: "duc-ios")
    /// showUsers(request: showUsersRequest)
    /// ```
    func getUserDetails(request: UserDetails.GetUserDetails.Request)
}

// MARK: - UserDetailsInteractor

class UserDetailsInteractor {
    init(
        presenter: UserDetailsPresentationLogic,
        repository: UserRepository
    ) {
        self.presenter = presenter
        self.repository = repository
    }

    private let presenter: UserDetailsPresentationLogic
    private let repository: UserRepository
}

// MARK: UserDetailsBusinessLogic

extension UserDetailsInteractor: UserDetailsBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: UserDetails.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func getUserDetails(request: UserDetails.GetUserDetails.Request) {
        Task { @MainActor in
            do {
                presenter.presentIsLoading(isLoading: true)
                let user = try await repository.getUser(login: request.login)
                presenter.presentIsLoading(isLoading: false)
                presenter.presentUserDetails(response: .init(user: user))
            } catch {
                presenter.presentIsLoading(isLoading: false)
                presenter.presentError(response: .init(error: .error(error)))
            }
        }
    }
}
