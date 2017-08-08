//
//  QPTableViewCell.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-07.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class QPTableViewCell: UITableViewCell {

  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var quoteLabel: UILabel!
  
   var quote: Quote! {
    didSet{
      authorLabel.text = quote.author
      quoteLabel.text = quote.quote
    }
  }

}
