//
//  Constants.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import os

typealias VoidCallback = () -> Void
typealias ValueCallback<T> = (T) -> Void

let logger = Logger()

// MARK: - Constants

enum Constants {
    static let perPage = 20
}
