//
//  LikesModel.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

struct Likes : Codable {
    let profiles : [LikeProfiles]?
    let canSeeProfile : Bool?
    let likesReceivedCount : Int?

    enum CodingKeys: String, CodingKey {

        case profiles = "profiles"
        case canSeeProfile = "can_see_profile"
        case likesReceivedCount = "likes_received_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try values.decodeIfPresent([LikeProfiles].self, forKey: .profiles)
        canSeeProfile = try values.decodeIfPresent(Bool.self, forKey: .canSeeProfile)
        likesReceivedCount = try values.decodeIfPresent(Int.self, forKey: .likesReceivedCount)
    }

}

struct LikeProfiles : Codable {
    let firstName : String?
    let avatar : String?

    enum CodingKeys: String, CodingKey {

        case firstName = "first_name"
        case avatar = "avatar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
    }

}
