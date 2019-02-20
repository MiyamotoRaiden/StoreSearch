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
  var artistName: String? = ""
  var trackName: String? = ""
  var kind: String? = ""
  
  var trackPrice: Double? = 0.0
  var currency = ""
  
  var imageSmall = ""
  var imageLarge = ""
  var storeURL: String? = ""
  var genre = ""
  
  enum CodingKeys: String, CodingKey {
    case imageSmall = "artworkUrl60"
    case imageLarge = "artworkUrl100"
    case storeURL = "trackViewUrl"
    case genre = "primaryGenreName"
    case kind, artistName, trackName
    case trackPrice, currency
  }
  
  var name:String {
    return trackName ?? ""
  }
  
  // requare property to conform to CustomStringConvertible
  var description: String {
    return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None")"
  }
  ///////////////////////////////////////////////////////////
  
  
  
}
