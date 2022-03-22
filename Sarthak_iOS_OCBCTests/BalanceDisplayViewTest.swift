//
//  BalanceViewTest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import XCTest
@testable import Sarthak_iOS_OCBC

class BalanceViewTest: XCTestCase {
    var balanceView: BalanceView!
    override func setUpWithError() throws {
        balanceView = BalanceView()
    }
    override func tearDownWithError() throws {
        balanceView = nil
    }
    func testViewWhenInitlised() {
        XCTAssertTrue(balanceView?.lblTopHeader.text?.isEmpty ?? false, "top label text should be empty")
        XCTAssertTrue(balanceView.lblBalance.text?.isEmpty ?? false, "balance label text should be empty")
        XCTAssertTrue(balanceView.lblAccountNoHeader.text?.isEmpty ?? false, "bottom label text should be empty")
        XCTAssertTrue(balanceView.lblAccountNo.text?.isEmpty ?? false, "bottom label text should be empty")
        XCTAssertTrue(balanceView.lblAccountHolderHeader.text?.isEmpty ?? false, "bottom label text should be empty")
        XCTAssertTrue(balanceView.lblAccountHolder.text?.isEmpty ?? false, "bottom label text should be empty")
    }
    func testWhenBalanceIsSetBalanceLabelIsVisible() {
        balanceView?.balance = "SGD 10"
        XCTAssertEqual(balanceView?.lblBalance.text, "SGD 10", "balance label text should be equal to SGD 10")
        XCTAssertFalse(balanceView?.lblBalance.isHidden ?? true, "balance label should not be hidden")
    }
    func testWhenTopTitleIsSetTopLabelIsVisible() {
        balanceView?.topText = "top"
        XCTAssertEqual(balanceView?.lblTopHeader.text, "top", "top label text should be equal to top")
        XCTAssertFalse(balanceView?.lblTopHeader.isHidden ?? true, "top label should not be hidden")
    }
    func testWhenAccountNoIsSetAccountNoLabelIsVisible() {
        balanceView?.accountNo = "12345678"
        XCTAssertEqual(balanceView?.lblAccountNo.text, "12345678", "bottom label text should be equal to 12345678")
        XCTAssertFalse(balanceView?.lblAccountNo.isHidden ?? true, "bottom label should not be hidden")
    }
    func testWhenAccountHolderTextIsSetAccountHolderLabelIsVisible() {
        balanceView?.accountHolder = "sarthak"
        XCTAssertEqual(balanceView?.lblAccountHolder.text, "sarthak", "bottom label text should be equal to 12345678")
        XCTAssertFalse(balanceView?.lblAccountHolder.isHidden ?? true, "bottom label should not be hidden")
    }
}
