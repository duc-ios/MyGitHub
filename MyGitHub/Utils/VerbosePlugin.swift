//
//  VerbosePlugin.swift
//  MyGitHub
//
//  Created by Duc on 9/9/24.
//

import Foundation
import Moya
import SwiftyJSON

// MARK: - VerbosePlugin

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if verbose {
            logger.debug("\(request.httpMethod ?? ""): \(request.url?.absoluteString ?? "")")
            logger.debug("HEADERS: \(request.headers))")
            if let body = request.httpBody,
               let str = String(data: body, encoding: .utf8)
            {
                logger.debug("BODY: \(str))")
            }
        }
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if verbose {
                logger.debug("RESPONSE: \(response.statusCode)")
                let json = JSON(response.data)
                if json != .null {
                    logger.debug("\(json)")
                } else {
                    let message = String(data: response.data, encoding: .utf8) ?? AppError.unexpected.message
                    logger.debug("\(message)")
                }
            }
        case .failure:
            break
        }
    }
}
