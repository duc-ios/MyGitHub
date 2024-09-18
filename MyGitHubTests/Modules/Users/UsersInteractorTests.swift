//
//  UsersInteractorTests.swift
//  MyGitHubTests
//
//  Created by Duc on 10/9/24.
//

@testable import MyGitHub
import SwiftData
import Testing

// MARK: - UsersInteractorTests

final class UsersInteractorTests {
    private var sut: UsersInteractor!
    private var presenter: UsersPresenterMock!
    private var repository: UserRepositoryMock!
    private var modelContainer: ModelContainer!

    init() {
        presenter = UsersPresenterMock()
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
        sut = UsersInteractor(
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
        sut = UsersInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.showError(request: .init(error: AppError.unexpected))

        // then
        #expect(presenter.error != nil, "Presenter should receive an error.")
    }

    @Test @MainActor func loadUsersSuccess() async throws {
        // given
        sut = UsersInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.loadUsers(request: .init(since: 0))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.users != nil, "Presenter should receive a non-nil response.")
    }

    @Test @MainActor func loadUsersFailure() async throws {
        // given
        sut = UsersInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.loadUsers(request: .init(since: -1))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.error != nil, "Presenter should receive a non-nil error.")
    }

    @Test @MainActor func showUsers() async throws {
        // given
        sut = UsersInteractor(
            presenter: presenter,
            repository: repository,
            modelContext: modelContainer.mainContext
        )

        // when
        sut.showUsers(request: .init(users: []))
        try await Task.sleep(for: .seconds(0.1))

        // then
        #expect(presenter.users != nil, "Presenter should receive a non-nil response.")
    }
}

// MARK: - UsersPresenterMock

class UsersPresenterMock: UsersPresentationLogic {
    var isLoading = false
    var error: Error?
    var users: [UserModel]?

    func presentIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func presentError(response: Users.ShowError.Response) {
        error = response.error
    }

    func presentUsers(response: Users.LoadUsers.Response) {
        users = response.users
    }
}

// MARK: - UserRepositoryMock

class UserRepositoryMock: UserRepository {
    func getUsers(since: Int) async throws -> [UserModel] {
        if since < 0 {
            throw AppError.badRequest
        } else {
            return []
        }
    }

    func getUser(login: String) async throws -> UserModel {
        if login.isBlank {
            throw AppError.badRequest
        } else {
            return UserModel()
        }
    }
}
