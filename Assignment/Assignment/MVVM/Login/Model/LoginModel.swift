//
//  LoginModel.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

struct LoginModel : Codable {
    let status : Bool?
}

struct OTPVerificationModel: Codable {
    let token : String?
}
