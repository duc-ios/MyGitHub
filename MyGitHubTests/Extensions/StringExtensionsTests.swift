//
//  StringExtensionsTests.swift
//  MyGitHubTests
//
//  Created by Duc on 18/9/24.
//

@testable import MyGitHub
import XCTest

class StringExtensionsTests: XCTestCase {
    func testTrimmed() {
        // given
        let string = "   hello world   "
        
        // when
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // then
        XCTAssertEqual(trimmed, "hello world", "string should be trimmed")
    }
    
    func testIsBlank() {
        // given
        let string = "   "
        
        // when
        let isBlank = string.isBlank
        
        // then
        XCTAssertTrue(isBlank, "string should be blank")
    }

    func testIsNilOrBlank() {
        // given
        let string: String? = nil
        
        // when
        let isNilOrBlank = string.isNilOrBlank
        
        // then
        XCTAssertTrue(isNilOrBlank, "string should be nil or blank")
    }
}
