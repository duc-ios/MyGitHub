//
//  AppError.swift
//  rp-mobile-swift
//
//  Created by Duc on 9/9/24.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription && lhs.message == rhs.message
    }

    case
        unimplemented,
        unexpected,
        unauthenticated,
        badRequest,
        notFound,
        network,
        error(Error),
        other(code: Int = -1, message: String)

    var errorDescription: String? {
        message
    }

    var title: String {
        switch self {
        case .network:
            return "No Network!"
        default:
            return "Something went wrong!"
        }
    }

    var message: String {
        switch self {
        case .unimplemented:
            return "Unimplemented"
        case .unexpected:
            return "Unexpected"
        case .unauthenticated:
            return "Unauthenticated"
        case .badRequest:
            return "Bad request"
        case .notFound:
            return "Not found"
        case .network:
            return "Please try again"
        case let .error(error):
            if let error = error as? AppError {
                return error.message
            } else {
                return (error as NSError).description
            }
        case let .other(code, message):
#if DEBUG
            return "\(code): \(message)"
#else
            return message
#endif
        }
    }
}
