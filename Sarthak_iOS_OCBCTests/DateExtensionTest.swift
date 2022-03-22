//
//  DateExtensionTest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import XCTest
@testable import Sarthak_iOS_OCBC

class DateExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateExtension() {
        let format = "dd MMM yyyy"
        let currentDate = Date()
        let strDate = currentDate.format(dateFormat: format)
        XCTAssertNotNil(strDate, "strDate should not be nil")
        let date = strDate.format(dateFormat: format)
        let strDate2 = date?.format(dateFormat: format)
        XCTAssertNotNil(date, "date should not be nil")
        XCTAssertEqual(strDate, strDate2, "both date should be equal")
    }

}
