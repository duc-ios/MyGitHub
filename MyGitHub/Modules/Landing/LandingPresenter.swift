//
//  LandingPresenter.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import UIKit

// MARK: - LandingPresentationLogic

protocol LandingPresentationLogic {
    /// Presents the loading state to the view.
    ///
    /// - Parameter isLoading: A boolean indicating whether the loading indicator should be shown (`true`) or hidden (`false`).
    ///
    /// Example:
    /// ```swift
    /// presentIsLoading(isLoading: true)  // Shows the loading indicator
    /// presentIsLoading(isLoading: false) // Hides the loading indicator
    /// ```
    func presentIsLoading(isLoading: Bool)

    /// Presents an error to the view based on the response provided.
    ///
    /// - Parameter response: A `Landing.ShowError.Response` object containing the error message and any additional error-related data to display in the view.
    ///
    /// Example:
    /// ```swift
    /// let errorResponse = Landing.ShowError.Response(message: "Network error", errorCode: 404)
    /// presentError(response: errorResponse)
    /// ```
    func presentError(response: Landing.ShowError.Response)

    /// Presents the list of users to the view after successfully loading the first page of GitHub users.
    ///
    /// - Parameter response: A `Landing.LoadFirstPageUsers.Response` object containing the array of users to be displayed in the view.
    ///
    /// Example:
    /// ```swift
    /// let usersResponse = Landing.LoadFirstPageUsers.Response(users: userList)
    /// presentUsers(response: usersResponse)
    /// ```
    func presentUsers(response: Landing.LoadFirstPageUsers.Response)
}

// MARK: - LandingPresenter

class LandingPresenter {
    init(view: any LandingDisplayLogic) {
        self.view = view
    }

    private var view: LandingDisplayLogic
}

// MARK: LandingPresentationLogic

extension LandingPresenter: LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }

    func presentAlert(response: Landing.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Landing.ShowError.Response) {
        view.event = .view(.error(response.error))
    }

    func presentUsers(response: Landing.LoadFirstPageUsers.Response) {
        view.event = .router(.users(response.users))
    }
}
