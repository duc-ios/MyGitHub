//
//  Moya+Concurency.swift
//  MyGitHub
//
//  Created by Duc on 7/9/24.
//

import Foundation
import Moya
import SwiftyJSON

extension MoyaProvider {
    class MoyaConcurrency {
        private let provider: MoyaProvider
        
        init(provider: MoyaProvider) {
            self.provider = provider
        }
        
        func request<T: Decodable>(_ target: Target) async throws -> T {
            do {
                let data = try await request(target)
                let res = try T.self(data: data)
                return res
            } catch {
                throw error
            }
        }
        
        func request(_ target: Target) async throws -> Data {
            try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        switch response.statusCode {
                        case 200..<400: // success
                            continuation.resume(returning: response.data)
                        case 401: // unauthenticated
                            continuation.resume(throwing: AppError.unauthenticated)
                        case 400..<500: // error
                            if let message = String(data: response.data, encoding: .utf8) {
                                continuation.resume(throwing: AppError.other(code: response.statusCode, message: message))
                            } else {
                                continuation.resume(throwing: AppError.unexpected)
                            }
                        default: // server error
                            continuation.resume(throwing: AppError.unexpected)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
}
