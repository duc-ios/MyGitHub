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
    var name: String?
    let login: String
    var bio: String?

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
                Text(name ?? login).font(.title2.weight(.semibold))
                if !name.isNilOrBlank {
                    Text(login)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
                Divider()
                if let bio {
                    Text(bio)
                        .foregroundStyle(.gray)
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
        name: "Name",
        login: "login"
    )
}
