//
//  ApiRequest.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
/// Api end points
enum ApiRequestUrl: String {
    case login = "/login"
    case register = "/register"
    case balances = "/balance"
    case transactions = "/transactions"
    case transfer = "/transfer"
    case payees = "/payees"
    /// Return the url string for given end point
    /// - Parameter api: api end point
    /// - Returns: A url string
    static func urlString(api: ApiRequestUrl) -> String {
        return String(format: "%@%@", APIManager.baseUrl, api.rawValue)
    }
}
/// Api manager for holding api constants
struct APIManager {
    static let baseUrl = "http://green-thumb-64168.uc.r.appspot.com"
    static var defaultTimeoutInterval: TimeInterval = 60
}

/// Api request type.
public enum ApiRequestMethodType {
    case GET
    case POST
}

