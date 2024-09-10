//
//  LandingPresenterTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import XCTest

// MARK: - LandingPresenterTests

class LandingPresenterTests: XCTestCase {
    private var sut: LandingPresenter!
    private var view: LandingDisplayLogicMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = LandingDisplayLogicMock()
        sut = LandingPresenter(view: view)
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
        sut.presentUsers(response: .init(users: []))
        
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

// MARK: - LandingDisplayLogicMock

class LandingDisplayLogicMock: LandingDisplayLogic {
    var isLoading = false
    var alertTitle: String?
    var alertMessage: String?
    var error: AppError?
    var users: [UserModel]?
    
    var event: LandingEvent? {
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
                }
            case .router(let router):
                switch router {
                case .users(let users):
                    self.users = users
                }
            default:
                break
            }
        }
    }
}
