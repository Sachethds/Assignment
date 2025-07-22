//
//  NotesModel.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

struct NotesModel : Codable {
    let invites : Invites?
    let likes : Likes?

    enum CodingKeys: String, CodingKey {

        case invites = "invites"
        case likes = "likes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        invites = try values.decodeIfPresent(Invites.self, forKey: .invites)
        likes = try values.decodeIfPresent(Likes.self, forKey: .likes)
    }

}







struct GeneralInformation : Codable {
    let firstName : String?
    let age : Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case age = "age"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
    }

}




