//
//  APIErrorHandling.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

enum ErrorHandling: LocalizedError {
    case invalidUrl
    case invalidURLResponse
    case invalidParameters
    case invalidStatusCode(status: Int)
    case decodingError(Error)
    
    
    var errorDescription: String? {
        
        switch self {
        case .invalidUrl:
            return "invalidUrl"
        case .invalidURLResponse:
            return "invalidResponse"
        case .invalidParameters:
            return "inavalid parameters"
        case .invalidStatusCode(status: let statusCode):
            return "invalid status code \(statusCode)"
        case .decodingError(let error):
            return "decoding error \(error)"
        }
    }
}
