//
//  UserRepositoryTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import XCTest

class UserRepositoryTests: XCTestCase {
    private var sut: UserRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testGetUsersSuccess() {
        // given
        sut = UserRepositoryImp()
        
        let promise = expectation(description: "Users Received")
        
        // when
        Task {
            var _error: Error?
            var users: [UserModel]?
            do {
                users = try await sut.getUsers(since: 0)
            } catch {
                _error = error
            }
            // then
            XCTAssertNil(_error, "Task should be completed without any error.")
            XCTAssertNotNil(users, "Task should return a list of UserModel.")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testGetUserDetailSuccess() {
        // given
        sut = UserRepositoryImp()
        
        let promise = expectation(description: "Users Received")
        
        // when
        Task {
            var _error: Error?
            var user: UserModel?
            do {
                user = try await sut.getUser(login: "duc-ios")
            } catch {
                _error = error
            }
            // then
            XCTAssertNil(_error, "Task should be completed without any error.")
            XCTAssertNotNil(user, "Task should return a UserModel.")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
