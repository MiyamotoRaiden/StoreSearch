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
  var dataTask: URLSessionDataTask?
  
  var hasSearched = false
  var isLoading = false
  
  //MARK:- Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  //MARK:- Actions
  @IBAction func segmentChanged(_ sender: UISegmentedControl) {
    performSearch()
  }
  
 //MARK:- TableView.CellIdentifiers
  struct TableView {
    struct CellIdentifiers {
      static let searchResultCell = "SearchResultCell"
      static let nothingFoundCell = "NothingFoundCell"
      static let loadingCell = "LoadingCell"
    }
  }
  
  //MARK:- viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
    
    var cellNib =
      UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
    tableView.register(cellNib,
                       forCellReuseIdentifier:TableView.CellIdentifiers.searchResultCell)
    
    cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
    tableView.register(cellNib,
        forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    
    cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
    tableView.register(cellNib,
                       forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    
    searchBar.becomeFirstResponder()
  }

  //MARK:-  Networking error alert
  func showNetworkError() {
    let alert = UIAlertController(title: "Whoops...",
      message: "There was an error accessing the iTunes Store."
               + " Please try again", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  //MARK:- Search
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    performSearch()
  }
}

extension SearchViewController: UISearchBarDelegate {
  
  //MARK:- Helper methods for searchBarSearchButtonClicked start
  func iTunesURL(searchText: String, category: Int) -> URL {
    
    let kind: String
    switch category {
    case 1: kind = "musikTrack"
    case 2: kind = "saftware"
    case 3: kind = "ebook"
    default: kind = ""
    }
    
    let encodedText = searchText.addingPercentEncoding(
      withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    
    let urlString = "https://itunes.apple.com/search?" +
      "term=\(encodedText)&limit=200&entity=\(kind)"
    
    let url = URL(string: urlString)
    return url!
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
  /////////////////////////////////////////////
  
  func performSearch() {
    
    if !searchBar.text!.isEmpty {
      searchBar.resignFirstResponder()
      dataTask?.cancel()
      isLoading = true
      tableView.reloadData()
      
      hasSearched = true
      searchResults = []
      
      let url = iTunesURL(searchText: searchBar.text!,
                          category: segmentedControl.selectedSegmentIndex)
      
      let session = URLSession.shared
      
      dataTask = session.dataTask(with: url, completionHandler:
      { data, response, error in
        if let error = error as NSError?, error.code == -999 {
          return
        } else if let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 {
          if let data = data {
            self.searchResults = self.parse(data: data)
            self.searchResults.sort(by: <)
            DispatchQueue.main.async {
              self.isLoading = false
              self.tableView.reloadData()
            }
            return
          }
        } else {
          print("Failur! response: \(response!)")
        }
        DispatchQueue.main.async {
          self.hasSearched = false
          self.isLoading = false
          self.tableView.reloadData()
          self.showNetworkError()
        }
      })
      dataTask?.resume()
    }
  }
  
  // position for bar
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
}

extension SearchViewController: UITableViewDelegate,
UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    if isLoading {
      return 1
    } else if !hasSearched {
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
    
    if isLoading {
      
      let cell = tableView.dequeueReusableCell(
        
        withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
      let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
      spinner.startAnimating()
      return cell
      
    } else if searchResults.count == 0 {
      return tableView.dequeueReusableCell(withIdentifier:
        TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
      
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier:
        TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
      
      let searchResult = searchResults[indexPath.row]
      cell.configure(for: searchResult)
      return cell
    }
  }
  
  
  // tableView willSelectRowAt
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if searchResults.count == 0 || isLoading { // Changing
      return nil
    } else {
      return indexPath
    }
  }
  
  // tableView didSelectRowAt
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "ShowDetail", sender: indexPath)
  }
  
}
