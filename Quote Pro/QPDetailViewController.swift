//
//  QPDetailViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class QPDetailViewController: UIViewController {
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  var loadedNib: QuoteView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    addQuoteView()
  }
  
  @IBAction func plusFontSize(_ sender: UIButton)
  {
    loadedNib.quoteLabel.font = UIFont.systemFont(ofSize: loadedNib.quoteLabel.font.pointSize + 1.0)
  }
  
  @IBAction func minusFontSize(_ sender: UIButton)
  {
    loadedNib.quoteLabel.font = UIFont.systemFont(ofSize: loadedNib.quoteLabel.font.pointSize - 1.0)
  }
  
  @IBAction func changeFontColor(_ sender: UISlider)
  {
    redSlider.value = roundf(redSlider.value)
    greenSlider.value = roundf(greenSlider.value)
    blueSlider.value = roundf(blueSlider.value)
    loadedNib.quoteLabel.textColor = UIColor(red: CGFloat(redSlider.value/255.0), green: CGFloat(greenSlider.value/255.0), blue: CGFloat(blueSlider.value/255.0), alpha: 1.0)
    loadedNib.authorLabel.textColor = UIColor(red: CGFloat(redSlider.value/255.0), green: CGFloat(greenSlider.value/255.0), blue: CGFloat(blueSlider.value/255.0), alpha: 1.0)
  }
  
  func addQuoteView()
  {
    loadedNib = Bundle.main.loadNibNamed("QuoteView", owner: nil)?.first as! QuoteView
    loadedNib.authorLabel.text = "Author"
    loadedNib.authorLabel.textColor = UIColor.white
    loadedNib.quoteLabel.text = "Quote"
    loadedNib.quoteLabel.textColor = UIColor.white
    loadedNib.imageView.image = UIImage.init(named: "image")
    view.addSubview(loadedNib)
    
    loadedNib.translatesAutoresizingMaskIntoConstraints = false
    loadedNib.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    loadedNib.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    loadedNib.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    let viewHeightConstraint = loadedNib.heightAnchor.constraint(equalToConstant: view.frame.height/2)
    viewHeightConstraint.isActive = true
    
  }
  
}
