//
//  UsersInteractor.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import SwiftUI

protocol UsersBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Users.ShowError.Request)
    func showUsers(request: Users.ShowUsers.Request)
}

class UsersInteractor {
    init(presenter: UsersPresentationLogic) {
        self.presenter = presenter
    }

    private let presenter: UsersPresentationLogic
}

extension UsersInteractor: UsersBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Users.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }
    
    func showUsers(request: Users.ShowUsers.Request) {
        presenter.presentUsers(response: .init(users: request.users))
    }
}
