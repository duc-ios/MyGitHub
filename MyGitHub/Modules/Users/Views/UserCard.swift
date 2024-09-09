//
//  UserCard.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftData
import SwiftUI

struct UserCard: View {
    let user: UserModel

    var body: some View {
        HStack(alignment: .top) {
            CachedAsyncImage(url: URL(string: user.avatarUrl ?? user.gravatarId ?? "")) {
                $0.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.login).font(.title2.weight(.semibold))
                Divider()
                Button {
                    guard let url = URL(string: user.htmlUrl) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text(user.htmlUrl)
                        .font(.caption)
                        .underline()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .primary, radius: 5, y: 3)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    let schema = Schema([UserModel.self])
    let container = try! ModelContainer(
        for: schema,
        configurations:
        ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    )
    return List {
        UserCard(user: UserModel(
            login: "login",
            htmlUrl: "https://github.com/login",
            avatarUrl: "https://avatars.githubusercontent.com/u/0"
        ))
        
        UserCard(user: UserModel(
            login: "login",
            htmlUrl: "https://github.com/login",
            avatarUrl: "https://avatars.githubusercontent.com/u/0"
        ))
    }
    .listStyle(.plain)
    .listRowBackground(Color.clear)
}
