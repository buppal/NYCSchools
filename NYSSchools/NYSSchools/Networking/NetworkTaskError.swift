//
//  NetworkTaskError.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import Foundation

enum NetworkTaskError: Error {
    case invalidResponse
    case httpError
    case parseError(underlyingError: Error)
}
