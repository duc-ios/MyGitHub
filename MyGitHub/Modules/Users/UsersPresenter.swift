//
//  UsersPresenter.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import UIKit

protocol UsersPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: Users.ShowError.Response)
    func presentUsers(response: Users.ShowUsers.Response)
}

class UsersPresenter {
    init(view: any UsersDisplayLogic) {
        self.view = view
    }

    private var view: UsersDisplayLogic
}

extension UsersPresenter: UsersPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: Users.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Users.ShowError.Response) {
        view.event = .view(.error(response.error))
    }
    
    func presentUsers(response: Users.ShowUsers.Response) {
        view.event = .view(.users(response.users))
    }
}
