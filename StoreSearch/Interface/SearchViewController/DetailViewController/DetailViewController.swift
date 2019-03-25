//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Ilya Tskhovrebov on 14/03/2019.
//  Copyright © 2019 Miyamoto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  //MARK:- IBOutlets
  @IBOutlet weak var popupView: UIView!
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var namelabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var kindLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var priceButton: UIButton!
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = .custom
    transitioningDelegate = self
  }
  
  
  // MARK:- Actons
  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
      popupView.layer.cornerRadius = 10
      
      let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                     action: #selector(close))
      gestureRecognizer.cancelsTouchesInView = false
      gestureRecognizer.delegate = self
      view.addGestureRecognizer(gestureRecognizer)
      
    }
    

  
  

}

extension DetailViewController:
UIViewControllerTransitioningDelegate {
  
  func presentationController( forPresented presented: UIViewController,
                               presenting: UIViewController?,
                               source: UIViewController) -> UIPresentationController? {
    return DimmmingPresentationController(
      presentedViewController: presented, presenting: presenting)
  }
}


extension DetailViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldReceive touch: UITouch) -> Bool {
    return (touch.view === self.view)
  }
}
