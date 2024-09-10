//
//  UsersInteractor.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import SwiftData
import SwiftUI

// MARK: - UsersBusinessLogic

protocol UsersBusinessLogic {
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
    /// - Parameter request: A `Users.ShowError.Request` object containing details about the error.
    ///
    /// Example:
    /// ```swift
    /// let errorRequest = Users.ShowError.Request(error: AppError.notFound)
    /// showError(request: errorRequest)
    /// ```
    func showError(request: Users.ShowError.Request)

    /// Handles the request to display a list of users in the view.
    ///
    /// - Parameter request: A `Users.ShowUsers.Request` object containing the data required to display users.
    ///
    /// Example:
    /// ```swift
    /// let showUsersRequest = Users.ShowUsers.Request(users: [UserModel()])
    /// showUsers(request: showUsersRequest)
    /// ```
    func showUsers(request: Users.ShowUsers.Request)

    /// Handles the request to load a list of users, typically by triggering a data fetch from a remote API or local database.
    ///
    /// - Parameter request: A `Users.LoadUsers.Request` object containing the parameters for fetching the users.
    ///
    /// Example:
    /// ```swift
    /// let loadUsersRequest = Users.LoadUsers.Request(since: 100)
    /// loadUsers(request: loadUsersRequest)
    /// ```
    func loadUsers(request: Users.LoadUsers.Request)
}

// MARK: - UsersInteractor

class UsersInteractor {
    init(presenter: UsersPresentationLogic,
         repository: UserRepository,
         modelContext: ModelContext)
    {
        self.presenter = presenter
        self.repository = repository
        self.modelContext = modelContext
    }

    private let presenter: UsersPresentationLogic
    private let repository: UserRepository
    private let modelContext: ModelContext!
}

// MARK: UsersBusinessLogic

extension UsersInteractor: UsersBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Users.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func showUsers(request: Users.ShowUsers.Request) {
        presenter.presentUsers(response: .init(users: request.users, hasMore: request.users.count >= Constants.perPage))
    }

    func loadUsers(request: Users.LoadUsers.Request) {
        Task { @MainActor in
            do {
                presenter.presentIsLoading(isLoading: true)
                let users = try await repository.getUsers(since: request.since)
                for user in users {
                    modelContext.insert(user)
                }
                presenter.presentIsLoading(isLoading: false)
                presenter.presentUsers(response: .init(users: users, hasMore: users.count >= Constants.perPage))
            } catch {
                presenter.presentIsLoading(isLoading: false)
                presenter.presentError(response: .init(error: .error(error)))
            }
        }
    }
}
