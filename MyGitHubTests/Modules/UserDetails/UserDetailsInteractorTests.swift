//
//  UsersInteractorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import SwiftData
import Testing
import UIKit

// MARK: - UserDetailsInteractorTests

final class UserDetailsInteractorTests {
    private var sut: UserDetailsInteractor!
    private var presenter: UserDetailsPresenterMock!
    private var modelContainer: ModelContainer!
    private var repository: UserRepositoryMock!

    init() {
        presenter = UserDetailsPresenterMock()
        repository = UserRepositoryMock()
        let schema = Schema([UserModel.self])
        modelContainer = try! ModelContainer(
            for: schema,
            configurations:
            ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        )
    }

    deinit {
        presenter = nil
        sut = nil
        modelContainer = nil
    }

    @Test func showLoading() {
        // given
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: repository
        )

        // when
        sut.showLoading(isLoading: true)

        // then
        #expect(presenter.isLoading == true, "Presenter should receive a loading state.")

        // when
        sut.showLoading(isLoading: false)

        // then
        #expect(presenter.isLoading == false, "Presenter should receive a loading state.")
    }

    @Test func showError() {
        // given
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: repository
        )

        // when
        sut.showError(request: .init(error: AppError.unexpected))

        // then
        #expect(presenter.error != nil, "Presenter should receive an error.")
    }

    @Test @MainActor func success() async throws {
        // given
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: repository
        )

        // when
        sut.getUserDetails(request: .init(login: "duc-ios"))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.user != nil, "Presenter should receive a non-nil user.")
    }

    @Test @MainActor func failure() async throws {
        // given
        sut = UserDetailsInteractor(
            presenter: presenter,
            repository: repository
        )

        // when
        sut.getUserDetails(request: .init(login: ""))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.error != nil, "Presenter should receive a non-nil error.")
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
