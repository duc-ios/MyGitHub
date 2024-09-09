//
//  BaseDataStore.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import Combine

// MARK: - BaseDataStore

class BaseDataStore: ObservableObject {
    @Published var isLoading = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var displayAlert = false
    
    var cancellables = Set<AnyCancellable>()
}
