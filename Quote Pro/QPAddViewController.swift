
//  QPAddViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddQuoteDelegate: class {
  
  func addNewQuote(quote:Quote)
  
}

class QPAddViewController: UIViewController {
  
  var nibView: QuoteView!
  @IBOutlet weak var imageSearchTerm: UITextField!
  @IBOutlet weak var languageButton: UIButton!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  
  let realm = try! Realm()
  var loadedNib: QuoteView!
  var viewHeightConstraint: NSLayoutConstraint!
  var isEnglish = true
  var quoteLabelOriginalCenter: CGPoint!
  var authorLabelOriginalCenter: CGPoint!
  weak var delegate: AddQuoteDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    addQuoteView()
    generateNewImage()
    generateNewQuote()
    
    loadedNib.imageView.isUserInteractionEnabled = true
    let quotePanGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleQuotePan(sender:)))
    loadedNib.quoteLabel.addGestureRecognizer(quotePanGesture)
    loadedNib.quoteLabel.isUserInteractionEnabled = true
    
    let authorPanGesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleAuthorPan(sender:)))
    loadedNib.authorLabel.addGestureRecognizer(authorPanGesture)
    loadedNib.authorLabel.isUserInteractionEnabled = true
  }
  
  
  override func viewDidLayoutSubviews()
  {
    quoteLabelOriginalCenter = loadedNib.quoteLabel.center
    authorLabelOriginalCenter = loadedNib.authorLabel.center
  }
  
  // MARK: Gesture Methods
  func handleQuotePan(sender:UIPanGestureRecognizer)
  {
    switch (sender.state)
    {
    case .began:
      loadedNib.quoteLabel.center = sender.location(in: loadedNib.imageView)
      break
    case .changed:
      loadedNib.quoteLabel.center = sender.location(in: loadedNib.imageView)
      break
    case .ended:
      loadedNib.quoteLabel.center = sender.location(in: loadedNib.imageView)
      if (!loadedNib.imageView.bounds.contains(loadedNib.quoteLabel.center))
      {
        loadedNib.quoteLabel.center = quoteLabelOriginalCenter
      }
      break
    default:
      if (!loadedNib.imageView.bounds.contains(loadedNib.quoteLabel.center))
      {
        loadedNib.quoteLabel.center = quoteLabelOriginalCenter
      }
      break
    }
  }
  
  func handleAuthorPan(sender:UIPanGestureRecognizer)
  {
    switch (sender.state)
    {
    case .began:
      loadedNib.authorLabel.center = sender.location(in: loadedNib.imageView)
      break
    case .changed:
      loadedNib.authorLabel.center = sender.location(in: loadedNib.imageView)
      break
    case .ended:
      loadedNib.authorLabel.center = sender.location(in: loadedNib.imageView)
      if (!loadedNib.imageView.bounds.contains(loadedNib.authorLabel.center))
      {
        loadedNib.authorLabel.center = authorLabelOriginalCenter
      }
      break
    default:
      if (!loadedNib.imageView.bounds.contains(loadedNib.authorLabel.center))
      {
        loadedNib.authorLabel.center = authorLabelOriginalCenter
      }
      break
    }
    
  }
  
  // MARK: Button Methods
  
  @IBAction func cancelButton(_ sender: UIBarButtonItem)
  {
    dismiss(animated: true)
  }
  @IBAction func saveButton(_ sender: UIBarButtonItem)
  {
    let quote = Quote()
    quote.author = loadedNib.authorLabel.text!
    quote.quote = loadedNib.quoteLabel.text!
    let photo = Photo()
    photo.image = UIImageJPEGRepresentation(loadedNib.imageView.image!, 1.0)!
    quote.photo = photo
    photo.quote = quote
  
    try! realm.write {
      realm.add(photo)
      realm.add(quote)
    }
    
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
    let title = isEnglish ? "English" : "Russian"
    sender.setTitle(title, for: UIControlState.normal)
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
  
  @IBAction func categoryInfoButton(_ sender: UIButton) {
    let categories = "abstract\nanimals\nbusiness\ncats\ncity\nfood\nnightlife\nfashion\npeople\nnature\nsports\ntechnics\ntransport"
    let alert = UIAlertController.init(title: "Category Info", message: categories, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction.init(title: "Done", style: UIAlertActionStyle.default, handler: { (alert) in
    }))
    present(alert, animated: true)
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
    loadedNib.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationController!.navigationBar.frame.height).isActive = true
    viewHeightConstraint = loadedNib.heightAnchor.constraint(equalToConstant: view.frame.height/5*2)
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
    let language = isEnglish ? "en" : "ru"
    
    NetworkManager.sharedManager.getQuote(language: language) { (quote, author) in
      OperationQueue.main.addOperation({
        self.loadedNib.quoteLabel.text = quote
        self.loadedNib.authorLabel.text = author
      })
    }
    
  }
}
