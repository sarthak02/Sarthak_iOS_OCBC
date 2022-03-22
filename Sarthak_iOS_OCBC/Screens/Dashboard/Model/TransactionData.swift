//
//  Data.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
struct TransactionData : Codable {
	let id : String?
    let type : String?
	let amount : Double?
	let currency : String?
	let sender : SenderInfo?
    let receipient : ReceipientInfo?
    let description : String?
	let date : String?

	enum CodingKeys: String, CodingKey {
		case id = "transactionId"
		case type = "transactionType"
		case amount = "amount"
		case currency = "currency"
		case sender = "sender"
        case receipient = "receipient"
		case description = "description"
		case date = "transactionDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
        sender = try values.decodeIfPresent(SenderInfo.self, forKey: .sender)
        receipient = try values.decodeIfPresent(ReceipientInfo.self, forKey: .receipient)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}
    init(id: String?, type: String?, amount: Double?, currency: String?, sender: SenderInfo?, receipient: ReceipientInfo?, date: String?, description: String?) {
        self.amount = amount
        self.type = type
        self.id = id
        self.currency = currency
        self.date = date
        self.sender = sender
        self.receipient = receipient
        self.description = description
    }
}
