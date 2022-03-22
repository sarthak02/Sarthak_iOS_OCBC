//
//  Date+Extension.swift
//  Sarthak_iOS_OCBC
//
//  Created by sarthak on 21/3/22.
//
import Foundation
public extension Date {
    /// Format the date object and return the string
    ///
    /// - Parameter dateFormat: A String value represent the date format
    /// - Returns: formatted string
    func format(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
