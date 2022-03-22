//
//  TransferViewModelTest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import XCTest
@testable import Sarthak_iOS_OCBC

class TransferViewModelTest: XCTestCase {

    var viewModel: TransferViewModel!
    override func setUpWithError() throws {
        viewModel = TransferViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.transferData, "Transaction data should not be nil")
            XCTAssertEqual(self.viewModel.transferData?.status, "success", "status should be true")
        }
        let apiRequest = MockAPIRequest.init(resource: TransferDataResource())
        apiRequest.load { data in
            self.viewModel.transferData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
        
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.transferData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }

}
