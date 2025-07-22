//
//  LoginNetworkService.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

protocol LoginService {
    func login<T: Codable>(apiData: inout APIData) async throws -> T?
}

protocol OTPVerificationService {
    func verifyOTP<T: Codable>(apiData: inout APIData) async throws -> T?
}

typealias LoginNetworking = LoginService & OTPVerificationService


class LoginNetworkService: LoginNetworking {
    let apiRequest: APIRequestProtocol
    
    init(apiRequest: APIRequestProtocol) {
        self.apiRequest = apiRequest
    }
    
    func login<T: Codable>(apiData: inout APIData) async throws -> T? {
        return try?  await self.apiRequest.post(apiData: &apiData)
    }

    func verifyOTP<T: Codable>(apiData: inout APIData) async throws -> T? {
        return try?  await self.apiRequest.post(apiData: &apiData)
    }
}
