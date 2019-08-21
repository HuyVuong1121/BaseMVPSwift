//
//  AccountSession.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

struct AccountSession: Codable {
    let authToken: String
    let email: String?
    let fullName: String
    let avatar: String
    let phone: String?
    
    private enum AccountSessionCodingKeys: String, CodingKey {
        case extra, auth_token, email, full_name, avatar, phone_number
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AccountSessionCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: AccountSessionCodingKeys.self, forKey: .extra)
        authToken = try nestedContainer.decode(String.self, forKey: .auth_token)
        email = try? nestedContainer.decode(String.self, forKey: .email)
        fullName = try nestedContainer.decode(String.self, forKey: .full_name)
        avatar = try nestedContainer.decode(String.self, forKey: .avatar)
        phone = try? nestedContainer.decode(String.self, forKey: .phone_number)
    }
    
}
