//
//  LoginViewModelTest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//

import XCTest
@testable import Sarthak_iOS_OCBC

class LoginViewModelTest: XCTestCase {

    var viewModel: LoginViewModel!
    override func setUpWithError() throws {
        viewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.loginData, "login data should not be nil")
            XCTAssertEqual(self.viewModel.loginData?.status, "success", "status should be true")
            XCTAssertNotNil(self.viewModel.loginData?.token, "login token should not be nil")
            XCTAssertNotNil(SessionManager.sharedInstance.authorizationToken, "session manager auth token should not be nil")
        }
        let apiRequest = MockAPIRequest.init(resource: LoginDataResource())
        apiRequest.load { data in
            self.viewModel.loginData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
    
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.loginData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }
}

