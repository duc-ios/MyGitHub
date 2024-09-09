//
//  UserDetailsInteractor.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

// MARK: - UserDetailsBusinessLogic

protocol UserDetailsBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: UserDetails.ShowError.Request)
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
