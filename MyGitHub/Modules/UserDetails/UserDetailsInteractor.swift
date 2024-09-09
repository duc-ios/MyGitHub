//
//  UserDetailsInteractor.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

protocol UserDetailsBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: UserDetails.ShowError.Request)
}

class UserDetailsInteractor {
    init(presenter: UserDetailsPresentationLogic) {
        self.presenter = presenter
    }

    private let presenter: UserDetailsPresentationLogic
}

extension UserDetailsInteractor: UserDetailsBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: UserDetails.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }
}
