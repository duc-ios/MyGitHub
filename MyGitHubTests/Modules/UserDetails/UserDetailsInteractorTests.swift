//
//  UsersInteractorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import SwiftData
import XCTest

// MARK: - UserDetailsInteractorTests

class UserDetailsInteractorTests: XCTestCase {
    private var sut: UserDetailsInteractor!
    private var presenter: UserDetailsPresenterMock!
    private var modelContainer: ModelContainer!

    override func setUpWithError() throws {
        try super.setUpWithError()

        let schema = Schema([UserModel.self])
        modelContainer = try! ModelContainer(
            for: schema,
            configurations:
            ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        )
    }

    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
        modelContainer = nil

        try super.tearDownWithError()
    }

    @MainActor func testSuccess() {
        // given
        presenter = UserDetailsPresenterMock()
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: UserRepositoryMock()
        )
        let promise = expectation(description: "User List Received")

        // when
        sut.getUserDetails(request: .init(login: "duc-ios"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            promise.fulfill()

            // then
            XCTAssertNotNil(self?.presenter.user, "Presenter should receive a non-nil user.")
        }

        wait(for: [promise], timeout: 5)
    }

    @MainActor func testFailure() {
        // given
        presenter = UserDetailsPresenterMock()
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: UserRepositoryMock()
        )
        let promise = expectation(description: "Error Received")

        // when
        sut.getUserDetails(request: .init(login: ""))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            promise.fulfill()

            // then
            XCTAssertNotNil(self?.presenter.error, "Presenter should receive a non-nil error.")
        }

        wait(for: [promise], timeout: 5)
    }
}

// MARK: - UserDetailsPresenterMock

class UserDetailsPresenterMock: UserDetailsPresentationLogic {
    var isLoading = false
    var error: Error?
    var user: UserModel?

    func presentIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func presentError(response: UserDetails.ShowError.Response) {
        error = response.error
    }

    func presentUserDetails(response: UserDetails.GetUserDetails.Response) {
        user = response.user
    }
}
