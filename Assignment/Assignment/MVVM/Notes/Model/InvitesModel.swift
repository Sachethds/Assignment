//
//  InvitesModel.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

struct Invites : Codable {
    let profiles : [InviteProfiles]?
    let totalPages : Int?
    let pending_invitations_count : Int?

    enum CodingKeys: String, CodingKey {

        case profiles = "profiles"
        case totalPages = "totalPages"
        case pending_invitations_count = "pending_invitations_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try values.decodeIfPresent([InviteProfiles].self, forKey: .profiles)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        pending_invitations_count = try values.decodeIfPresent(Int.self, forKey: .pending_invitations_count)
    }

}

struct InviteProfiles : Codable {
    let generalInformation : GeneralInformation?
    let photos :[Photos]?

    enum CodingKeys: String, CodingKey {

        case generalInformation = "general_information"
        case photos = "photos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        generalInformation = try values.decodeIfPresent(GeneralInformation.self, forKey: .generalInformation)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
    }

}

struct Photos : Codable {
    let photo : String?
    let photo_id : Int?
    let selected : Bool?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case photo = "photo"
        case photo_id = "photo_id"
        case selected = "selected"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        photo_id = try values.decodeIfPresent(Int.self, forKey: .photo_id)
        selected = try values.decodeIfPresent(Bool.self, forKey: .selected)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
