//
//  LandingInteractorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import SwiftData
import XCTest

// MARK: - LandingInteractorTests

class LandingInteractorTests: XCTestCase {
    private var sut: LandingInteractor!
    private var presenter: LandingPresenterMock!
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

    @MainActor func testLoadFirstPageUsersSuccess() {
        // given
        presenter = LandingPresenterMock()
        sut = LandingInteractor(
            presenter: presenter,
            repository: UserRepositoryMock(),
            modelContext: modelContainer.mainContext
        )
        let promise = expectation(description: "User List Received")

        // when
        sut.loadFirstPageUsers(request: .init(since: 0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            promise.fulfill()

            // then
            XCTAssertNotNil(self?.presenter.users, "Presenter should receive a non-nil response.")
        }

        wait(for: [promise], timeout: 5)
    }

    @MainActor func testLoadFirstPageUsersFailure() {
        // given
        presenter = LandingPresenterMock()
        sut = LandingInteractor(
            presenter: presenter,
            repository: UserRepositoryMock(),
            modelContext: modelContainer.mainContext
        )
        let promise = expectation(description: "Error Received")

        // when
        sut.loadFirstPageUsers(request: .init(since: -1))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            promise.fulfill()

            // then
            XCTAssertNotNil(self?.presenter.error, "Presenter should receive a non-nil error.")
        }

        wait(for: [promise], timeout: 5)
    }
}

// MARK: - LandingPresenterMock

class LandingPresenterMock: LandingPresentationLogic {
    var isLoading = false
    var error: Error?
    var users: [UserModel]?

    func presentIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func presentError(response: Landing.ShowError.Response) {
        error = response.error
    }
    
    func presentUsers(response: Landing.LoadFirstPageUsers.Response) {
        self.users = response.users
    }
}
