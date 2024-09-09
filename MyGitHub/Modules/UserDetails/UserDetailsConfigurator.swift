//
//  UserDetailsConfigurator.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation

extension UserDetailsView {
    func configured(
        user: UserModel
    ) -> UserDetailsView {
        var view = self
        let presenter = UserDetailsPresenter(view: view.store)
        let interactor = UserDetailsInteractor(presenter: presenter)
        view.interactor = interactor
        view.store.user = user
        return view
    }
}
