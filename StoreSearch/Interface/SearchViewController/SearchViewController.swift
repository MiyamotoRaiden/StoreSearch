//
//  ViewController.swift
//  StoreSearch
//
//  Created by Ilya Tskhovrebov on 11/02/2019.
//  Copyright © 2019 Miyamoto. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

  //MARK:- properties
  var searchResults = [SearchResult]()
  var hasSearched = false
  
  //MARK:- Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  //MARK:- Structs with reuse identifiers
  struct TableView {
    struct CellIdentifiers {
      static let searchResultCell = "SearchResultCell"
      static let nothingFoundCell = "NothingFoundCell"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    
    var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell,
                        bundle: nil)
    
    tableView.register(cellNib, forCellReuseIdentifier:TableView.CellIdentifiers.searchResultCell)
    
    cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
    tableView.register(cellNib,
        forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    
    searchBar.becomeFirstResponder()
  }

  //MARK:-  Networking error alert
  func showNetworkingError() {
    let alert = UIAlertController(title: "Whoops...",
      message: "There was an error accessing the iTunes Store."
               + " Please try again", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
}

extension SearchViewController: UISearchBarDelegate {
  
  //MARK:- Helper methods for searchBarSearchButtonClicked start
  
  func iTunesURL(searchText: String) -> URL {
    let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    let urlString = String( format: "https://itunes.apple.com/search?term=%@", encodedText )
    let url = URL(string: urlString)
    return url!
  }
  
  func performStoreRequest(with url: URL) -> Data? {
    do {
      return try Data(contentsOf: url)
    } catch {
      print("Download Error: \"(error.localizedDescription)")
      showNetworkingError()
      return nil
    }
  }
  
  func parse(data: Data) -> [SearchResult] {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(ResultArray.self, from: data)
      return result.results
    } catch {
      print("JSON Error: \(error)")
      return []
    }
  }
  
  ////////////////////////////////////////////////
  
  
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    if !searchBar.text!.isEmpty {
    
      searchBar.resignFirstResponder()
      
      hasSearched = true
      searchResults = []
      
     let url = iTunesURL(searchText: searchBar.text!)
     print("URL: '\(url)'")
      if let data = performStoreRequest(with: url) {
        searchResults = parse(data: data)
      }
      tableView.reloadData()
    }
    
  }
  
  
}

extension SearchViewController: UITableViewDelegate,
UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    if !hasSearched {
      return 0
    } else if searchResults.count == 0 {
      return 1
    } else {
        return searchResults.count
    }
  
  }
  
  //  tableView cellForRowAt
  func tableView(_ tableView: UITableView,
       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if searchResults.count == 0 {
      return tableView.dequeueReusableCell(withIdentifier:
        TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier:
        TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
      
      let searchResult = searchResults[indexPath.row]
      cell.nameLabel.text = searchResult.name
      cell.artistNameLabel.text = searchResult.artistName
      return cell
    }
  }
  
  
  // position for bar
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  // tableView willSelectRowAt
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if searchResults.count == 0 {
      return nil
    } else {
      return indexPath
    }
  }
  
  // tableView didSelectRowAt
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  
  
  
  
}
