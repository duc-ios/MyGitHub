//
//  UserDetailsPresenter.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import UIKit

protocol UserDetailsPresentationLogic {
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
    /// - Parameter response: A `GetUserDetails.ShowError.Response` object containing the error message and any additional error-related data to display in the view.
    ///
    /// Example:
    /// ```swift
    /// let errorResponse = UserDetails.ShowError.Response(message: "Network error", errorCode: 404)
    /// presentError(response: errorResponse)
    /// ```
    func presentError(response: UserDetails.ShowError.Response)
    
    /// Presents the user detail to the view after processing a response from loading user details.
    ///
    /// - Parameter response: A `Users.GetUserDetails.Response` object that contains the user details to display.
    ///
    /// Example:
    /// ```swift
    /// let usersResponse = UserDetails.GetUserDetails.Response(users: userList)
    /// presentUsers(response: usersResponse)
    /// ```
    func presentUserDetails(response: UserDetails.GetUserDetails.Response)
}

class UserDetailsPresenter {
    init(view: any UserDetailsDisplayLogic) {
        self.view = view
    }

    private var view: UserDetailsDisplayLogic
}

extension UserDetailsPresenter: UserDetailsPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: UserDetails.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: UserDetails.ShowError.Response) {
        view.event = .view(.error(response.error))
    }
    
    func presentUserDetails(response: UserDetails.GetUserDetails.Response) {
        view.event = .view(.user(response.user))
    }
}
