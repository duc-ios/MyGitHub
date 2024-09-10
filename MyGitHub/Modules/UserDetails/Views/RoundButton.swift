//
//  RoundButton.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

struct RoundButton: View {
    let iconName: String
    let total: String
    let title: String
    let action: VoidCallback

    var body: some View {
        Button(action: action, label: {
            VStack {
                Image(systemName: iconName)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                    .font(.body)
                Text(total).bold()
                Text(title)
            }
            .font(.caption)
        })
    }
}

#Preview {
    HStack {
        RoundButton(iconName: "person.2.fill", total: "100+", title: "Followers") {}

        RoundButton(iconName: "figure.walk", total: "100+", title: "Followings") {}
    }
}
