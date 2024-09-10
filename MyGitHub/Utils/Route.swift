//
//  Route.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

enum Route: Hashable {
    case users([UserModel]),
         userDetails(UserModel)
}
