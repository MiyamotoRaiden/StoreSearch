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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    
    let cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
  }
  
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchResults = []
    
    if searchBar.text! != "justin bieber" {
      for i in 0...2 {
        let searchResult = SearchResult()
        searchResult.name = String(format: "Fake Result %d for", i)
        searchResult.artistName = searchBar.text!
        searchResults.append(searchResult)
      }
    }
    hasSearched = true
    tableView.reloadData()
  }
}

extension SearchViewController: UITableViewDelegate,
UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if !hasSearched {
      return 0
    } else if searchResults.count == 0 {
      return 1
    } else {
        return searchResults.count
    }
  
  }
  
  //  tableView cellForRowAt
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(
                withIdentifier: "SearchResultCell", for: indexPath)
                as! SearchResultCell
    
    if searchResults.count == 0 {
      cell.nameLabel.text = "(Nothing found)"
      cell.artistNameLabel.text = ""
    } else {
    let searchResult = searchResults[indexPath.row]
    cell.nameLabel.text = searchResult.name
    cell.artistNameLabel.text = searchResult.artistName
  }
    return cell
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
