//
//  LandingView.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

// MARK: - LandingEvent

enum LandingEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError)
    }

    enum Router: Equatable {
        case users([UserModel])
    }

    case view(View), router(Router)
}

// MARK: - LandingDisplayLogic

protocol LandingDisplayLogic {
    var event: LandingEvent? { get set }
}

// MARK: - LandingView

struct LandingView: View {
    var interactor: LandingBusinessLogic!
    @ObservedObject var store = LandingDataStore()
    @EnvironmentObject var router: Router

    private var error: String?

    var body: some View {
        VStack {
            if store.isLoading {
                Text("Loading...")
                Spacer().frame(height: 24)
                ProgressView()
                    .scaleEffect(x: 2, y: 2)
            } else {
                Text("Error!")
                Text("Failed to load data, please try again later.")
            }
        }
        .onChange(of: store.event) { _, new in
            guard case let .router(event) = new else { return }
            switch event {
            case let .users(users):
                router.pop(to: .users(users))
            }
        }
        .onAppear {
            interactor.loadFirstPageUsers(request: .init(since: 0))
        }
    }
}

#if DEBUG
#Preview {
    LandingView().configured()
}
#endif
