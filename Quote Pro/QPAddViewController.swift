
//  QPAddViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class QPAddViewController: UIViewController {
  
  @IBOutlet weak var nibView: QuoteView!
  @IBOutlet weak var imageSearchTerm: UITextField!
  
  var loadedNib: QuoteView!
  var viewHeightConstraint: NSLayoutConstraint!
  var isEnglish = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    addQuoteView()
    generateNewImage()
    generateNewQuote()
    
  }
  // MARK: Button Methods
  
  @IBAction func cancelButton(_ sender: UIBarButtonItem)
  {
    dismiss(animated: true)
  }
  @IBAction func saveButton(_ sender: UIBarButtonItem)
  {
    dismiss(animated: true)
  }
  
  @IBAction func plusFontSize(_ sender: UIButton)
  {
    loadedNib.quoteLabel.font = UIFont.systemFont(ofSize: loadedNib.quoteLabel.font.pointSize + 1.0)
  }
  
  @IBAction func minusFontSize(_ sender: UIButton)
  {
    loadedNib.quoteLabel.font = UIFont.systemFont(ofSize: loadedNib.quoteLabel.font.pointSize - 1.0)
  }
  
  @IBAction func languageButton(_ sender: UIButton)
  {
    isEnglish = !isEnglish
    generateNewQuote()
  }
  
  @IBAction func randomizeQuote(_ sender: UIButton)
  {
    generateNewQuote()
  }
  
  @IBAction func randomizeImage(_ sender: UIButton)
  {
    generateNewImage()
  }
  
  
  func addQuoteView()
  {
    loadedNib = Bundle.main.loadNibNamed("QuoteView", owner: nil)?.first as! QuoteView
    loadedNib.authorLabel.text = "Author"
//    loadedNib.authorLabel.adjustsFontSizeToFitWidth = true
    loadedNib.quoteLabel.text = "Quote"
//    loadedNib.quoteLabel.adjustsFontSizeToFitWidth = true
    loadedNib.imageView.image = UIImage.init(named: "image")
    view.addSubview(loadedNib)
    
    loadedNib.translatesAutoresizingMaskIntoConstraints = false
    loadedNib.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    loadedNib.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    loadedNib.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    viewHeightConstraint = loadedNib.heightAnchor.constraint(equalToConstant: view.frame.height/2)
    viewHeightConstraint.isActive = true
    
  }
  
  func generateNewImage()
  {
    let category = imageSearchTerm.text ?? ""
    NetworkManager.sharedManager.getImage(width: 400, height: 300, category: category) { (imageData) in
      OperationQueue.main.addOperation({
        self.loadedNib.imageView.image = UIImage.init(data: imageData)
      })
    }
  }
  
  func generateNewQuote()
  {
    let language = isEnglish ? "en" : "fr"
    NetworkManager.sharedManager.getQuote(language: language) { (quote, author) in
      OperationQueue.main.addOperation({ 
        self.loadedNib.quoteLabel.text = quote
        self.loadedNib.authorLabel.text = author
      })
    }
    
  }
}
