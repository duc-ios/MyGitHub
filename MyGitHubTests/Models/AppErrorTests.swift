//
//  AppErrorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 18/9/24.
//

@testable import MyGitHub
import XCTest

class AppErrorTests: XCTestCase {
    func testTitle() {
        // given
        let error = AppError.unexpected
        
        // when
        let title = error.title
        
        // then
        XCTAssertEqual(title, "Unexpected Error", "title is not correct")
    }
    
    func testMessage() {
        // given
        let error = AppError.unexpected
        
        // when
        let message = error.message
        
        // then
        XCTAssertEqual(message, "An unexpected error occurred.", "message is not correct")
    }
    
    func testErrorDescription() {
        // given
        let error = AppError.unexpected
        
        // when
        let description = error.errorDescription
        
        // then
        XCTAssertEqual(description, "Unexpected Error: An unexpected error occurred.", "description is not correct")
    }
}
