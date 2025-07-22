//
//  NotesVM.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

@MainActor
class NotesVM: ObservableObject  {
    @Published var notesDetails: NotesModel?
    
    let notesServices: NotesServices
    init(notesServices: NotesServices = NotesNetworkServices(apiRequest: APIRequest(apiManager: APIManager()))) {
        self.notesServices = notesServices
    }
    
    func getNotesDetails() async {
        var apiData = APIData(url: APPURL.notesList.url)
        do {
            let notesResponse: NotesModel? = try await self.notesServices.fetchNotesDetails(apiData: &apiData)
            notesDetails = notesResponse
        } catch let error as ErrorHandling {
            print(error.errorDescription ?? "")
        } catch {
            print("unknown error \(error.localizedDescription)")
        }
    }

}
