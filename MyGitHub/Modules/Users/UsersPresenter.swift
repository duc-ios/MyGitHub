//
//  UsersPresenter.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import UIKit

// MARK: - UsersPresentationLogic

protocol UsersPresentationLogic {
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
    /// - Parameter response: A `Users.ShowError.Response` object containing the error message and any additional error-related data to display in the view.
    ///
    /// Example:
    /// ```swift
    /// let errorResponse = Users.ShowError.Response(message: "Network error", errorCode: 404)
    /// presentError(response: errorResponse)
    /// ```
    func presentError(response: Users.ShowError.Response)

    /// Presents the list of users to the view after processing a response from loading users.
    ///
    /// - Parameter response: A `Users.LoadUsers.Response` object that contains the list of users to display.
    ///
    /// Example:
    /// ```swift
    /// let usersResponse = Users.LoadUsers.Response(users: userList)
    /// presentUsers(response: usersResponse)
    /// ```
    func presentUsers(response: Users.LoadUsers.Response)
}

// MARK: - UsersPresenter

class UsersPresenter {
    init(view: any UsersDisplayLogic) {
        self.view = view
    }

    private var view: UsersDisplayLogic
}

// MARK: UsersPresentationLogic

extension UsersPresenter: UsersPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }

    func presentAlert(response: Users.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Users.ShowError.Response) {
        view.event = .view(.error(response.error))
    }

    func presentUsers(response: Users.LoadUsers.Response) {
        view.event = .view(.users(users: response.users, hasMore: response.hasMore))
    }
}
