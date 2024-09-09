//
//  UserModel.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import SwiftData

// MARK: - UserModel

@Model
final class UserModel {
    @Attribute(.unique) var id: Int 
    var login: String

    init(
        id: Int = 0,
        login: String = ""
    ) {
        self.id = id
        self.login = login
    }
}

// MARK: Codable

extension UserModel: Codable {
    enum CodingKeys: CodingKey {
        case id, login
    }

    convenience init(from decoder: any Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
    }
}
