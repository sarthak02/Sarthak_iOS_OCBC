//
//  BalanceData.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct BalanceData: Codable {
    let status : String?
    var balance : Double?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case balance = "balance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        balance = try values.decodeIfPresent(Double.self, forKey: .balance)
    }
}
