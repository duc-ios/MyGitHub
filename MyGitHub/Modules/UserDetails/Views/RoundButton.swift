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
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            Text(total).bold()
            Text(title)
        }
        .font(.caption)
    }
}

#Preview {
    HStack {
        RoundButton(iconName: "person.2.fill", total: "100+", title: "Followers")
        
        RoundButton(iconName: "figure.walk", total: "100+", title: "Followings")
    }
}
