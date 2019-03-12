//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Ilya Tskhovrebov on 14/02/2019.
//  Copyright © 2019 Miyamoto. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
  
  var downloadTask: URLSessionDownloadTask?
  
  //MARK:- Outlets
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
      selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255,
                                                 blue: 160/255, alpha: 0.5)
      selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  //MARK:- override func
  override func prepareForReuse() {
    super.prepareForReuse()
    downloadTask?.cancel()
    downloadTask = nil
  }
  
  //MARK:-Custom methods
  func configure(for result: SearchResult) {
    nameLabel.text = result.name
    
    if result.artist.isEmpty {
      artistNameLabel.text = "Unknown"
    } else {
      artistNameLabel.text = String(format: "%@ (%@)", result.artist, result.type)
    }
    
    artworkImageView.image = UIImage(named: "Placeholder")
    if let smallURL = URL(string: result.imageSmall) {
      downloadTask = artworkImageView.loadImage(url: smallURL)
    }
    
  }

}
