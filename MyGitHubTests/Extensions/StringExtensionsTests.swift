//
//  StringExtensionsTests.swift
//  MyGitHubTests
//
//  Created by Duc on 18/9/24.
//

@testable import MyGitHub
import Testing

final class StringExtensionsTests {
    @Test func trimmed() {
        // given
        let string = "   hello world   "
        
        // when
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // then
        #expect(trimmed == "hello world", "string should be trimmed")
    }
    
    @Test func isBlank() {
        // given
        let string = "   "
        
        // when
        let isBlank = string.isBlank
        
        // then
        #expect(isBlank == true, "string should be blank")
    }

    @Test func isNilOrBlank() {
        // given
        let string: String? = nil
        
        // when
        let isNilOrBlank = string.isNilOrBlank
        
        // then
        #expect(isNilOrBlank == true, "string should be nil or blank")
    }
}
