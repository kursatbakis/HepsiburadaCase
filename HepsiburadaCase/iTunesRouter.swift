//
//  iTunesRouter.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import Foundation

let baseUrl = "https://itunes.apple.com/search?"
let itemsPerPage = 20
enum iTunesRouter {
    
    case movies(word: String, offset: Int)
    case music(word: String, offset: Int)
    case ebook(word: String, offset: Int)
    case podcast(word: String, offset: Int)
    
    var path: URL {
        switch self {
        
        case let .movies(word: word, offset: offset):
            return URL(string: baseUrl + "term=\(word)&media=movie&limit=\(itemsPerPage)&offset=\(offset)")!
        case let .music(word: word, offset: offset):
            return URL(string: baseUrl + "term=\(word)&media=music&limit=\(itemsPerPage)&offset=\(offset)")!
        case let .ebook(word: word, offset: offset):
            return URL(string: baseUrl + "term=\(word)&media=ebook&limit=\(itemsPerPage)&offset=\(offset)")!
        case let .podcast(word: word, offset: offset):
            return URL(string: baseUrl + "term=\(word)&media=podcast&limit=\(itemsPerPage)&offset=\(offset)")!
        }
    }
}
