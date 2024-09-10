//
//  MyGitHubApp.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import SwiftData
import SwiftUI

let sharedModelContainer: ModelContainer = {
    let schema = Schema([
        UserModel.self
    ])
    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
        return try ModelContainer(for: schema, configurations: [configuration])
    } catch {
        do {
            try FileManager.default.removeItem(at: configuration.url)
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}()

// MARK: - MyGitHubApp

@main
struct MyGitHubApp: App {
    var body: some Scene {
        WindowGroup {
            AppView().tint(.primary)
        }
        .modelContainer(sharedModelContainer)
    }
}
