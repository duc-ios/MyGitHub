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
        let presenter = LandingPresenter(view: view.store)
        let interactor = LandingInteractor(
            presenter: presenter,
            repository: UserRepositoryImp(),
            modelContext: sharedModelContainer.mainContext
        )
        view.interactor = interactor
        return view
    }
}
