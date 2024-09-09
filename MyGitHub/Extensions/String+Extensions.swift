//
//  String+Extensions.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var isBlank: Bool { trimmed.isEmpty }
}

extension Optional<String> {
    var isNilOrBlank: Bool { (self ?? "").isBlank }
}
