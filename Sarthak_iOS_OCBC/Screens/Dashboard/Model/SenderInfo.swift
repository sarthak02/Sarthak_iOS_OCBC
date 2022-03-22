//
//  SenderInfo.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct SenderInfo: Codable {
	let accountNo : String?
	let accountHolder : String?

	enum CodingKeys: String, CodingKey {

		case accountNo = "accountNo"
		case accountHolder = "accountHolder"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		accountNo = try values.decodeIfPresent(String.self, forKey: .accountNo)
        accountHolder = try values.decodeIfPresent(String.self, forKey: .accountHolder)
	}

}
