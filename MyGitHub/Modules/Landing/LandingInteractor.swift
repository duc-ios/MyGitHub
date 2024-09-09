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
    func showLoading(isLoading: Bool)
    func showError(request: Landing.ShowError.Request)
    func loadFirstPageUsers(request: Landing.LoadFirstPageUsers.Request)
}

// MARK: - LandingInteractor

class LandingInteractor {
    init(presenter: LandingPresentationLogic,
         repository: UserRepository,
         modelContext: ModelContext
    ) {
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
