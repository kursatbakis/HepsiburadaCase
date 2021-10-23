//
//  Formatter.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import Foundation

class Formatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        formatter.locale = enUSPosixLocale
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
}
