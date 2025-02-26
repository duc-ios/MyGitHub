//
//  MD5.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import CommonCrypto
import Foundation

enum MD5 {
    static func data(_ string: String) -> Data {
        let length = Int(CommonCrypto.CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CommonCrypto.CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }

    static func hex(_ data: Data) -> String {
        let md5Hex = data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
}
