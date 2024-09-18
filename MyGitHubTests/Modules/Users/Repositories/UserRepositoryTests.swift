//
//  UserRepositoryTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import Testing

final class UserRepositoryTests {
    private var sut: UserRepository!
    
    init() {
        sut = UserRepositoryImp()
    }
    
    deinit {
        sut = nil
    }
    
    @Test func getUsersSuccess() async throws {
        // given
        
        // when
        let users = try await sut.getUsers(since: 0)
        
        // then
        #expect(users != nil, "Task should return a list of UserModel.")
    }
    
    @Test func getUserDetailSuccess() async throws {
        // given
        
        // when
        let user = try await sut.getUser(login: "duc-ios")
        
        // then
        #expect(user != nil, "Task should return a UserModel.")
    }
}
