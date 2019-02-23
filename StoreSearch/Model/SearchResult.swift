//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Ilya Tskhovrebov on 12/02/2019.
//  Copyright © 2019 Miyamoto. All rights reserved.
//

import Foundation

class ResultArray: Codable {
  var resultCount = 0
  var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
  
  var currency = ""
  
  var imageSmall = ""
  var imageLarge = ""
  
  // requare property to conform to CustomStringConvertible
  var description: String {
    return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None")"
  }
  
  var kind: String? = ""
  var artistName: String? = ""
  
  
  // name computed property
  var name: String {
    return trackName ?? collectionName ?? ""
  }
  var trackName: String? = ""
  var collectionName: String?
  
  //// URL computed property
  var storeURL: String {
    return trackViewUrl ?? collectionViewUrl ?? ""
  }
  var trackViewUrl: String?
  var collectionViewUrl: String?
  
   //// price computed property
  var price: Double {
    return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
  }
  var trackPrice: Double? = 0.0
  var collectionPrice: Double?
  var itemPrice: Double?
  
  //////// genre computed property
  
  var genre: String {
    if let genre = itemGenre {
      return genre
    } else if let genres = bookGenre {
      return genres.joined(separator: ", ")
    }
    return ""
  }
  
  var itemGenre: String?
  var bookGenre: [String]?
  /////////////////////////////////////////
 
  enum CodingKeys: String, CodingKey {
    case imageSmall = "artworkUrl60"
    case imageLarge = "artworkUrl100"
    case itemGenre = "primaryGenreName"
    case bookGenre = "genres"
    case itemPrice = "price"
    case kind, artistName, currency
    case trackName, trackPrice, trackViewUrl
    case collectionName, collectionViewUrl, collectionPrice
  }
  

  
  
}
