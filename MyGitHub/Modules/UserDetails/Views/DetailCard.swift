//
//  DetailCard.swift
//  MyGitHub
//
//  Created by Duc on 10/9/24.
//

import SwiftUI

struct DetailCard: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .bold()
            }
            .font(.title3)
            
            Text(detail)
                .foregroundStyle(Color(.systemGray))
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    DetailCard(
        icon: "pencil.and.scribble",
        title: "Blog",
        detail: "https://www.google.com"
    )
}
