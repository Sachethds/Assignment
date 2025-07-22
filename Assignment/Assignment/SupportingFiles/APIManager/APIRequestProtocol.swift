//
//  APIRequestProtocol.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

protocol APIGettable {
    func fetch<T: Codable>(apiData: inout APIData) async throws -> T?
}

protocol APIPostable {
    func post<T: Codable>(apiData: inout APIData) async throws -> T?
}


typealias APIRequestProtocol = APIGettable & APIPostable

class APIRequest: APIRequestProtocol {
    let apiManager: ApiManagerRequestProtocol?
    
    init(apiManager: ApiManagerRequestProtocol) {
        self.apiManager = apiManager
    }
    func fetch<T>(apiData: inout APIData) async throws -> T? where T : Decodable, T : Encodable {
        apiData.method = "GET"
        return try await apiManager?.sendRequest(apiData: apiData, response: T.self)
    }
    
    func post<T>(apiData: inout APIData) async throws -> T? where T : Decodable, T : Encodable {
        apiData.method = "POST"
        return try await apiManager?.sendRequest(apiData: apiData, response: T.self)
    }
    
    
}
