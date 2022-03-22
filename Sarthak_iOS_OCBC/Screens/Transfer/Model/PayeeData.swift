//
//  PayeeData.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import Foundation
struct PayeeData : Codable {
    let id : String?
    let accountNo : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountNo = "accountNo"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        accountNo = try values.decodeIfPresent(String.self, forKey: .accountNo)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
