//
//  UserDetailsConfigurator.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation

extension UserDetailsView {
    func configured(
        login: String
    ) -> UserDetailsView {
        var view = self
        let presenter = UserDetailsPresenter(view: view.store)
        let interactor = UserDetailsInteractor(
            presenter: presenter,
            repository: UserRepositoryImp()
        )
        view.interactor = interactor
        view.store.login = login
        return view
    }
}
