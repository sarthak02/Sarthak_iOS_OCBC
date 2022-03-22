//
//  SessionManager.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
/// Store the session related information.
class SessionManager: NSObject {
    static let sharedInstance = SessionManager()
    var authorizationToken: String = ""
    var username: String = ""
    var accountNo: String = ""
}
