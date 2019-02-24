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
  
  // kind computed property
  var type: String {
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
  var kind: String? = ""
  
  // artist computed property
  var artist: String {
    return artistName ?? ""
  }
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

func < ( lhs: SearchResult, rhs: SearchResult) -> Bool {
  return lhs.name.localizedStandardCompare(rhs.name) ==
  .orderedAscending
}
