//
//  APIManager.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

protocol ApiManagerRequestProtocol {
    func sendRequest<T:Codable>(apiData: APIData, response: T.Type) async throws -> T?
}

class APIManager: ApiManagerRequestProtocol {
    
    
    func sendRequest<T: Codable>(apiData: APIData, response: T.Type) async throws -> T? {
        let fullUrl = baseUrl + apiData.url
        let url = URL(string: fullUrl)
        guard let apiURL = url else {
            throw ErrorHandling.invalidUrl
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = apiData.method
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            let headers = ["Authorization":"Bearer \(token)"]
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let requestBody = apiData.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            } catch {
                throw ErrorHandling.invalidParameters
            }
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        
        guard let response = urlResponse as? HTTPURLResponse else {
            throw ErrorHandling.invalidURLResponse
        }
        
        guard (200...299).contains(response.statusCode) else{
            throw ErrorHandling.invalidStatusCode(status: response.statusCode)
        }
        
        do {
            let decodeResponse = try JSONDecoder().decode(T.self, from: data)
            return decodeResponse
        } catch {
            throw ErrorHandling.decodingError(error)
        }
    }
}

