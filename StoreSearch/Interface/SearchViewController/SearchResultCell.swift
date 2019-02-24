//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Ilya Tskhovrebov on 14/02/2019.
//  Copyright © 2019 Miyamoto. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

  
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

}