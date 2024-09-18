//
//  LandingInteractorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import SwiftData
import Testing

// MARK: - LandingInteractorTests

class LandingInteractorTests {
    private var sut: LandingInteractor!
    private var presenter: LandingPresenterMock!
    private var repository: UserRepositoryMock
    private var modelContainer: ModelContainer!

    init() {
        presenter = LandingPresenterMock()
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

    @Test @MainActor func showLoading() {
        // given
        sut = LandingInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
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
    

    @Test @MainActor func showError() {
        // given
        sut = LandingInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.showError(request: .init(error: AppError.unexpected))

        // then
        #expect(presenter.error != nil, "Presenter should receive an error.")
    }

    @Test @MainActor func loadFirstPageUsersSuccess() async throws {
        // given
        sut = LandingInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.loadFirstPageUsers(request: .init(since: 0))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.users != nil, "Presenter should receive a non-nil response.")
    }

    @Test @MainActor func loadFirstPageUsersFailure() async throws {
        // given
        sut = LandingInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.loadFirstPageUsers(request: .init(since: -1))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.error != nil, "Presenter should receive a non-nil error.")
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
        users = response.users
    }
}
