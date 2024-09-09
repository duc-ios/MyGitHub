//
//  UserDetailsHeader.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftData
import SwiftUI

struct UserDetailsHeader: View {
    let avatarUrl: String?
    let login: String
    let location: String?

    var body: some View {
        HStack(alignment: .top) {
            CachedAsyncImage(url: URL(string: avatarUrl ?? "")) {
                $0.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(login).font(.title2.weight(.semibold))
                Divider()
                if let location {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(location)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .primary.opacity(0.3), radius: 5, y: 3)
    }
}

#Preview {
    let schema = Schema([UserModel.self])
    let container = try! ModelContainer(
        for: schema,
        configurations:
        ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    )
    return UserDetailsHeader(
        avatarUrl: "https://avatars.githubusercontent.com/u/0",
        login: "login",
        location: "Vietnam"
    )
}
