//
//  UserDetailsDataStore.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Combine
import Foundation

// MARK: - UserDetailsDataStore

final class UserDetailsDataStore: BaseDataStore, UserDetailsDisplayLogic {
    // MARK: - Variables

    @Published var event: UserDetailEvent?

    var login: String!

    @Published var name: String = ""
    @Published var avatarUrl: String = ""
    @Published var location: String = ""
    @Published var followers: Int = 0
    @Published var following: Int = 0
    @Published var blog: String = ""

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
        case .user(let user):
            name = user.name ?? ""
            if let avatarUrl = user.avatarUrl {
                self.avatarUrl = avatarUrl
            } else if let gravatarId = user.gravatarId {
                self.avatarUrl = "http://www.gravatar.com/avatar/\(MD5(gravatarId))?s=100"
            }
            location = user.location ?? "N/A"
            followers = user.followers
            following = user.following
            blog = user.blog ?? "N/A"
        }
    }
}

import typealias CommonCrypto.CC_LONG
import func CommonCrypto.CC_MD5
import var CommonCrypto.CC_MD5_DIGEST_LENGTH

func MD5(_ string: String) -> Data {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    let messageData = string.data(using: .utf8)!
    var digestData = Data(count: length)

    _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
        messageData.withUnsafeBytes { messageBytes -> UInt8 in
            if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                let messageLength = CC_LONG(messageData.count)
                CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
            }
            return 0
        }
    }
    return digestData
}
