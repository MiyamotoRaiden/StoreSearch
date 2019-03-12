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
  
  // kind
  var kind: String? = ""
  
  var type: String { // return more human readeble kind
    let kind = self.kind ?? "audiobook"
    switch kind {
    case "album": return "Album"
    case "audiobook": return "Audio Book"
    case "book": return "Book"
    case "ebook": return "E-Book"
    case "feature-movie": return "Movie"
    case "music-video": return "Music Video"
    case "podcast": return "Podcast"
    case "software": return "app"
    case "song": return "Song"
    case "tv-episode": return "TV Episode"
    default: break
    }
    return "Unknown"
  }
  
  
  // artist
  var artistName: String? = ""
  
  var artist: String {
    return artistName ?? ""
  }

  
  // name
  
  var trackName: String? = ""
  var collectionName: String?
  
  var name: String {
    return trackName ?? collectionName ?? ""
  }

  
  //// URL
  var trackViewUrl: String?
  var collectionViewUrl: String?
  
  var storeURL: String {
    return trackViewUrl ?? collectionViewUrl ?? ""
  }
  
  
   //// price
  var trackPrice: Double? = 0.0
  var collectionPrice: Double?
  var itemPrice: Double?
  
  var price: Double {
    return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
  }
 
  
  
  
  //////// genre
  var itemGenre: String?
  var bookGenre: [String]?
  
  var genre: String {
    if let genre = itemGenre {
      return genre
    } else if let genres = bookGenre {
      return genres.joined(separator: ", ")
    }
    return ""
  }
  /////////////////////////////////////////
  
  // requare property to conform to CustomStringConvertible
  var description: String {
    return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None")"
  }
  ////////////////////////////////
  
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

func < ( lhs: SearchResult, rhs: SearchResult) -> Bool {
  return lhs.name.localizedStandardCompare(rhs.name) ==
  .orderedAscending
}
