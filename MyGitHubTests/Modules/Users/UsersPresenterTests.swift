//
//  UsersPresenterTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import XCTest

// MARK: - UsersPresenterTests

class UsersPresenterTests: XCTestCase {
    private var sut: UsersPresenter!
    private var view: UsersDisplayLogicMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = UsersDisplayLogicMock()
        sut = UsersPresenter(view: view)
    }
    
    override func tearDownWithError() throws {
        view = nil
        sut = nil

        UIView.setAnimationsEnabled(true)

        try super.tearDownWithError()
    }
    
    func testPresentUsers() {
        // given
        
        // when
        sut.presentUsers(response: .init(users: [], hasMore: true))
        
        // then
        XCTAssertNotNil(view.users, "View should receive a non-nil user list.")
    }
    
    func testPresentError() {
        // given
        
        // when
        sut.presentError(response: .init(error: AppError.notFound))
        
        // then
        XCTAssertNotNil(view.error, "View should receive a non-nil error.")
    }
}

// MARK: - UsersDisplayLogicMock

class UsersDisplayLogicMock: UsersDisplayLogic {
    var isLoading = false
    var alertTitle: String?
    var alertMessage: String?
    var error: AppError?
    var users: [UserModel]?
    var hasMore = false
    
    var event: UsersEvent? {
        didSet {
            switch event {
            case .view(let view):
                switch view {
                case .loading(let isLoading):
                    self.isLoading = isLoading
                case .alert(let title, let message):
                    alertTitle = title
                    alertMessage = message
                case .error(let error):
                    self.error = error
                case .users(let users, let hasMore):
                    self.users = users
                    self.hasMore = hasMore
                }
            default:
                break
            }
        }
    }
}
