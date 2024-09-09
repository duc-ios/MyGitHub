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
    func showLoading(isLoading: Bool)
    func showError(request: Users.ShowError.Request)
    func showUsers(request: Users.ShowUsers.Request)
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
