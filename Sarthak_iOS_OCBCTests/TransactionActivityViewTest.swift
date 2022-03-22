//
//  TransactionViewTest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import XCTest
@testable import Sarthak_iOS_OCBC

class TransactionActivityViewTest: XCTestCase {

    var transactionView: TransactionView!
    override func setUpWithError() throws {
        transactionView = TransactionView()
    }
    override func tearDownWithError() throws {
        transactionView = nil
    }
    func testViewWhenInitlised() {
        XCTAssertTrue(transactionView?.lblDate.text?.isEmpty ?? false, "date label text should be empty")
        XCTAssertTrue(transactionView.lblTitle.text?.isEmpty ?? false, "title label text should be empty")
        XCTAssertTrue(transactionView.lblAmount.text?.isEmpty ?? false, "amount label text should be empty")
    }
    func testWhenAmountIsSetAmountLabelIsVisible() {
        transactionView?.setAmount(amount: "10", isCredited: true)
        XCTAssertEqual(transactionView?.lblAmount.text, "10", "amount label text should be equal to 10")
        XCTAssertFalse(transactionView?.lblAmount.isHidden ?? true, "amount label should not be hidden")
    }
    func testWhenTitleIsSetTitleLabelIsVisible() {
        transactionView?.title = "sent"
        XCTAssertEqual(transactionView?.lblTitle.text, "sent", "title text should be equal to top")
        XCTAssertFalse(transactionView?.lblTitle.isHidden ?? true, "title should not be hidden")
    }
    func testWhenBottomTextIsSetBottomLabelIsVisible() {
        transactionView?.date = "date"
        XCTAssertEqual(transactionView?.lblDate.text, "date", "date label text should be equal to date")
        XCTAssertFalse(transactionView?.lblDate.isHidden ?? true, "date label should not be hidden")
    }

}
