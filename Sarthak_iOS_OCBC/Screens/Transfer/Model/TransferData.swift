//
//  TransferData.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import Foundation
struct TransferData: Codable {
    let status : String?
    let id : String?
    let recipientAccountNo : String?
    let amount : Int?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case id = "transactionId"
        case recipientAccountNo = "recipientAccount"
        case amount = "amount"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        recipientAccountNo = try values.decodeIfPresent(String.self, forKey: .recipientAccountNo)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
