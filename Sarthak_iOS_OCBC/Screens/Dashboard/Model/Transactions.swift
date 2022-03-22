//
//  TransactionData.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct Transactions: Codable {
	let status : String?
	let transactionData : [TransactionData]?

	enum CodingKeys: String, CodingKey {
		case status = "status"
		case transactionData = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
        transactionData = try values.decodeIfPresent([TransactionData].self, forKey: .transactionData)
	}

}
