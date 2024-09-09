//
//  UINavigationController+Extensions.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import UIKit

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationBar.backIndicatorImage = .init(systemName: "arrow.left")
        navigationBar.backIndicatorTransitionMaskImage = .init(systemName: "arrow.left")
    }
}
