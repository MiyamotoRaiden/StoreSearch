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

class SearchResult: Codable {
  var artistName: String? = ""
  var trackName: String? = ""
  
  var name:String {
    return trackName ?? ""
  }
}
