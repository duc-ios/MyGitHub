//
//  UserDetailsDataStore.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Combine
import Foundation

final class UserDetailsDataStore: BaseDataStore, UserDetailsDisplayLogic {
    @Published var event: UserDetailEvent?

    var user: UserModel!

    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .compactMap {
                guard case .view(let event) = $0 else { return nil }
                return event
            }
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: UserDetailEvent.View) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        }
    }
}
