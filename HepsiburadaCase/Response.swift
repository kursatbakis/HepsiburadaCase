//
//  Response.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import Foundation

struct Response: Codable {
    var resultCount: Int
    var results: [Result]
}

struct Result: Codable {
    var wrapperType: String?
    var explicitness: String?
    var trackName: String
    var artistName: String
    var collectionName: String?
    var previewUrl: String?
    var artworkUrl100: String
    var collectionPrice: Double?
    var releaseDate: String
    var longDescription: String?
    var primaryGenreName: String?
}
