//
//  UserDetailsPresenter.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import UIKit

protocol UserDetailsPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: UserDetails.ShowError.Response)
}

class UserDetailsPresenter {
    init(view: any UserDetailsDisplayLogic) {
        self.view = view
    }

    private var view: UserDetailsDisplayLogic
}

extension UserDetailsPresenter: UserDetailsPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: UserDetails.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: UserDetails.ShowError.Response) {
        view.event = .view(.error(response.error))
    }
}
