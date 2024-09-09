//
//  LandingPresenter.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import UIKit

protocol LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: Landing.ShowError.Response)
    func presentUsers(response: Landing.LoadFirstPageUsers.Response)
}

class LandingPresenter {
    init(view: any LandingDisplayLogic) {
        self.view = view
    }

    private var view: LandingDisplayLogic
}

extension LandingPresenter: LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: Landing.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Landing.ShowError.Response) {
        view.event = .view(.error(response.error))
    }
    
    func presentUsers(response: Landing.LoadFirstPageUsers.Response) {
        view.event = .router(.users)
    }
}
