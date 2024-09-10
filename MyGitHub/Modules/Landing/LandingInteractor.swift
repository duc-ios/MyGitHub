//
//  LandingInteractor.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftData
import SwiftUI

// MARK: - LandingBusinessLogic

protocol LandingBusinessLogic {
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
    /// - Parameter request: A `Landing.ShowError.Request` object containing details about the error.
    ///
    /// Example:
    /// ```swift
    /// let errorRequest = Landing.ShowError.Request(error: AppError.notFound)
    /// showError(request: errorRequest)
    /// ```
    func showError(request: Landing.ShowError.Request)

    /// Handles the request to load the first page of GitHub users, sending the request to the interactor for further processing.
    ///
    /// - Parameter request: A `Landing.LoadFirstPageUsers.Request` object containing pagination or filtering information for loading the first page of users.
    ///
    /// Example:
    /// ```swift
    /// let request = Landing.LoadFirstPageUsers.Request(since: 100)
    /// loadFirstPageUsers(request: request)
    /// ```
    func loadFirstPageUsers(request: Landing.LoadFirstPageUsers.Request)
}

// MARK: - LandingInteractor

class LandingInteractor {
    init(presenter: LandingPresentationLogic,
         repository: UserRepository,
         modelContext: ModelContext)
    {
        self.presenter = presenter
        self.repository = repository
        self.modelContext = modelContext
    }

    private let presenter: LandingPresentationLogic
    private let repository: UserRepository
    private let modelContext: ModelContext!
}

// MARK: LandingBusinessLogic

extension LandingInteractor: LandingBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Landing.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func loadFirstPageUsers(request: Landing.LoadFirstPageUsers.Request) {
        do {
            let users: [UserModel] = try modelContext.fetch(.init(sortBy: [.init(\.id, order: .forward)]))

            if users.isEmpty {
                Task { @MainActor in
                    do {
                        presenter.presentIsLoading(isLoading: true)
                        let users = try await repository.getUsers(since: 0)
                        for user in users {
                            modelContext.insert(user)
                        }
                        presenter.presentIsLoading(isLoading: false)
                        presenter.presentUsers(response: .init(users: users))
                    } catch {
                        presenter.presentIsLoading(isLoading: false)
                        presenter.presentError(response: .init(error: .error(error)))
                    }
                }
            } else {
                presenter.presentUsers(response: .init(users: users))
            }
        } catch {
            presenter.presentError(response: .init(error: .error(error)))
        }
    }
}
