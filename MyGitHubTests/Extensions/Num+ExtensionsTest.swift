//
//  Num+ExtensionsTest.swift
//  MyGitHubTests
//
//  Created by Duc on 17/9/24.
//

@testable import MyGitHub
import Testing

final class NumExtensionsTests {
    @Test func stringValue() {
        // given
        let num = 99

        // when
        let result = num.stringValue

        // then
        #expect(result == "99", "Should return a string '99'.")
    }
}
