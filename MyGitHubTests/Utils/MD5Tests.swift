//
//  MD5Tests.swift
//  MyGitHubTests
//
//  Created by Duc on 17/9/24.
//

@testable import MyGitHub
import Testing

final class MD5Tests {
    @Test func md5() {
        // given
        let str = "duc-ios"

        // when
        let data = MD5.data(str)
        let hex = MD5.hex(data)

        // then
        #expect(hex == "2d9b6a76c3ba10985dde37ba0baef5b4", "Should return md5 hash string.")
    }
}
