//
//  AppErrorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 18/9/24.
//

@testable import MyGitHub
import Testing

class AppErrorTests {
    @Test func title() {
        // given
        let error = AppError.unexpected
        
        // when
        let title = error.title
        
        // then
        #expect(title == "Unexpected Error", "title is not correct")
    }
    
    @Test func message() {
        // given
        let error = AppError.unexpected
        
        // when
        let message = error.message
        
        // then
        #expect(message == "An unexpected error occurred.", "message is not correct")
    }
    
    @Test func errorDescription() {
        // given
        let error = AppError.unexpected
        
        // when
        let description = error.errorDescription
        
        // then
        #expect(description == "Unexpected Error: An unexpected error occurred.", "description is not correct")
    }
}
