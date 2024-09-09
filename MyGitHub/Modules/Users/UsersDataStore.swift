//
//  UsersDataStore.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import Combine

final class UsersDataStore: BaseDataStore, UsersDisplayLogic {
    @Published var event: UsersEvent?
    
    // MARK: - Variable
    
    @Published var users: [UserModel] = []

    // MARK: -
    
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

    func reduce(_ event: UsersEvent.View) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case .users(let users):
            self.users = users
        }
    }
}
