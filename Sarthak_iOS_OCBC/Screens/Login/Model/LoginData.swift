//
//  LoginData.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct LoginData: Codable {
    let status: String?
    let token: String
    let username: String?
    let accountNo: String?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case token = "token"
        case username = "username"
        case accountNo = "accountNo"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? ""
        username = try values.decodeIfPresent(String.self, forKey: .username)
        accountNo = try values.decodeIfPresent(String.self, forKey: .accountNo)
    }
}
