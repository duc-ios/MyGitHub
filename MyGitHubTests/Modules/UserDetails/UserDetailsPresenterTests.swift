//
//  UsersDetailPresenterTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import XCTest

// MARK: - UserDetailsPresenterTests

class UserDetailsPresenterTests: XCTestCase {
    private var sut: UserDetailsPresenter!
    private var view: UserDetailsDisplayLogicMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = UserDetailsDisplayLogicMock()
        sut = UserDetailsPresenter(view: view)
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
        sut.presentUserDetails(response: .init(user: UserModel()))
        
        // then
        XCTAssertNotNil(view.user, "View should receive a non-nil user.")
    }
    
    func testPresentError() {
        // given
        
        // when
        sut.presentError(response: .init(error: AppError.notFound))
        
        // then
        XCTAssertNotNil(view.error, "View should receive a non-nil error.")
    }
}

// MARK: - UserDetailsDisplayLogicMock

class UserDetailsDisplayLogicMock: UserDetailsDisplayLogic {
    var isLoading = false
    var alertTitle: String?
    var alertMessage: String?
    var error: AppError?
    var user: UserModel?
    
    var event: UserDetailsEvent? {
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
                case .user(let user):
                    self.user = user
                }
            default:
                break
            }
        }
    }
}
