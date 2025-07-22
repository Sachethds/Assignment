//
//  NotesNetworkServices.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

protocol FetchNotesService {
    func fetchNotesDetails<T: Codable>(apiData: inout APIData) async throws -> T?
}

typealias NotesServices = FetchNotesService

class NotesNetworkServices : NotesServices {
    
    let apiRequest: APIRequestProtocol
    
    init(apiRequest: APIRequestProtocol) {
        self.apiRequest = apiRequest
    }
    
    func fetchNotesDetails<T: Codable>(apiData: inout APIData) async throws -> T? {
        return try? await self.apiRequest.fetch(apiData: &apiData)
    }
}
