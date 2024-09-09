//
//  LandingConfigurator.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation

extension LandingView {
    func configured(
    ) -> LandingView {
        var view = self
        let presenter = LandingPresenter(view: view)
        let interactor = LandingInteractor(presenter: presenter)
        view.interactor = interactor
        return view
    }
}
