//
//  MD5.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import Foundation
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
