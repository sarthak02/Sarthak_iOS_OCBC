//
//  TransactionActivityTableViewCell.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import UIKit

class TransactionActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionView: TransactionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(transactionData: TransactionData) {
        let isReceived = transactionData.type == "received"
        let strAmount: String = String(format: "%.2f", transactionData.amount ?? 0).formatIntoCurrency(prefix: "", locale: Locale.init(identifier: "en_SG"))

        self.transactionView.setAmount(amount: (isReceived) ? "+\(strAmount)" : "-\(strAmount)" , isCredited: isReceived)
        if let date = transactionData.date?.format(dateFormat: Common.dateFormat) {
            self.transactionView.date = date.format(dateFormat: "dd MMM yyyy")
        }
        self.transactionView.title = isReceived ? "Received from \(transactionData.sender?.accountHolder ?? "")" : "Transfer to \(transactionData.receipient?.accountHolder ?? "")"
    }
}
