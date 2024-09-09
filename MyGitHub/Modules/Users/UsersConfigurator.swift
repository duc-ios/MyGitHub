//
//  UsersConfigurator.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation

extension UsersView {
    func configured(
        users: [UserModel]
    ) -> UsersView {
        var view = self
        let presenter = UsersPresenter(view: view.store)
        let interactor = UsersInteractor(presenter: presenter)
        view.interactor = interactor
        view.store.users = users
        return view
    }
}
