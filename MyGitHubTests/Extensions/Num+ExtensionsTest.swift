//
//  Num+ExtensionsTest.swift
//  MyGitHubTests
//
//  Created by Duc on 17/9/24.
//

@testable import MyGitHub
import XCTest

class NumExtensionsTests: XCTestCase {
    func testStringValue() {
        // given
        let num = 99
        
        // when
        let result = num.stringValue
        
        // then
        XCTAssertEqual(result, "99", "Should return a string '99'.")
    }
    
    func testSecondsToNanoSeconds() {
        // given
        let num = 99
        
        // when
        let result = num.secondsToNanoSeconds
        
        // then
        XCTAssertEqual(result, 99000000000, "Should return a number 99000000000.")
    }
}
