//
//  UsersDetailPresenterTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import Testing
import UIKit

// MARK: - UserDetailsPresenterTests

final class UserDetailsPresenterTests {
    private var sut: UserDetailsPresenter!
    private var view: UserDetailsDisplayLogicMock!
    
    init() {
        UIView.setAnimationsEnabled(false)

        view = UserDetailsDisplayLogicMock()
        sut = UserDetailsPresenter(view: view)
    }
    
    deinit {
        view = nil
        sut = nil

        UIView.setAnimationsEnabled(true)
    }
    
    @Test func presentUserDetails() {
        // given
        
        // when
        sut.presentUserDetails(response: .init(user: UserModel()))
        
        // then
        #expect(view.user != nil, "View should receive a non-nil user.")
    }
    
    @Test func presentIsLoadingTrue() {
        // given
        let isLoading = true
        
        // when
        sut.presentIsLoading(isLoading: isLoading)
        
        // then
        #expect(view.isLoading == isLoading, "View should receive the isLoading.")
    }
    
    @Test func presentIsLoadingFalse() {
        // given
        let isLoading = false
        
        // when
        sut.presentIsLoading(isLoading: isLoading)
        
        // then
        #expect(view.isLoading == isLoading, "View should receive the isLoading.")
    }
    
    @Test func presentAlert() {
        // given
        let alertTitle = "Title"
        let alertMessage = "Message"
        
        // when
        sut.presentAlert(response: .init(title: alertTitle, message: alertMessage))
        
        // then
        #expect(view.alertTitle == alertTitle, "View should receive the alert title.")
        #expect(view.alertMessage == alertMessage, "View should receive the alert message.")
    }
    
    @Test func presentError() {
        // given
        let error = AppError.notFound

        // when
        sut.presentError(response: .init(error: error))
        
        // then
        #expect(view.error == error, "View should receive the error.")
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
