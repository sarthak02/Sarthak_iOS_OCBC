//
//  TransferResponse.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import Foundation
struct TransferResponse : Codable {
    let id : String?
    let recipientAccountNo : String?
    let amount : Int?
    let date : String?
    let description : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case recipientAccountNo = "recipientAccountNo"
        case amount = "amount"
        case date = "date"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        recipientAccountNo = try values.decodeIfPresent(String.self, forKey: .recipientAccountNo)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
