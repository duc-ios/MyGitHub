//
//  LandingInteractor.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

// MARK: - LandingBusinessLogic

protocol LandingBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Landing.ShowError.Request)
    func loadFirstPageUsers(request: Landing.LoadFirstPageUsers.Request)
}

// MARK: - LandingInteractor

class LandingInteractor {
    init(presenter: LandingPresentationLogic) {
        self.presenter = presenter
    }

    private let presenter: LandingPresentationLogic
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
        Task { @MainActor in
            do {
                presenter.presentIsLoading(isLoading: true)
                try await Task.sleep(nanoseconds: 2.secondsToNanoSeconds)
                presenter.presentIsLoading(isLoading: false)
                presenter.presentUsers(response: .init(users: [UserModel(id: 0, login: "Login")]))
            } catch {
                presenter.presentIsLoading(isLoading: false)
                presenter.presentError(response: .init(error: .error(error)))
            }
        }
    }
}
