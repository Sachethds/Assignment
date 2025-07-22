//
//  APIEndPoints.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

var baseUrl = "https://app.aisle.co/V1/"

enum APPURL {
    case login
    case verification
    case notesList
    
    var url : String {
        switch self {
        case .login:
            "users/phone_number_login"
        case .verification:
            "users/verify_otp"
        case .notesList:
            "users/test_profile_list"
        }
    }
}
