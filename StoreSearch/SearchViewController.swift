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
  var searchResults = [String]()
  
  //MARK:- Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
  }


  
}


extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchResults = []
    for i in 0...2 {
      searchResults.append(String(format:
      "Fake Result %d for '%@'", i, searchBar.text!))
    }
    tableView.reloadData()
  }
  
}


extension SearchViewController: UITableViewDelegate,
UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "SearchResultCell"
    
    var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    
    if cell == nil {  // if cell wasn't been reused
      cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
    }
    cell.textLabel!.text = searchResults[indexPath.row]
    return cell
  }
  
  
}
