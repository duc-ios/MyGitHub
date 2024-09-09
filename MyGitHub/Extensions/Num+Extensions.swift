//
//  Num+Extensions.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation

extension Numeric {
    var stringValue: String { String(describing: self) }
}

extension Int {
    var secondsToNanoSeconds: UInt64 {
        UInt64(self) * 1_000_000_000
    }
}
