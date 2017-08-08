//
//  QPDetailViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import Social
import Messages
import MessageUI
import MobileCoreServices

class QPDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate {
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  var loadedNib: QuoteView!
  var quote: Quote!
  var quoteLabelOriginalCenter: CGPoint!
  var authorLabelOriginalCenter: CGPoint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    addQuoteView()
    loadedNib.authorLabel.text = quote.author
    loadedNib.quoteLabel.text = quote.quote
    loadedNib.imageView.image = UIImage.init(data: quote.photo!.image)
    
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
  
  
  // MARK: Button Methods
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
  
  @IBAction func facebookShare(_ sender: UIButton)
  {
    let snapshot = createSnapshot()
    let socialController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    socialController!.add(snapshot)
    present(socialController!, animated: true)
  }
  
  @IBAction func twitterShare(_ sender: UIButton)
  {
    let snapshot = createSnapshot()
    let socialController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    socialController!.add(snapshot)
    present(socialController!, animated: true)
  }
  @IBAction func messageShare(_ sender: UIButton)
  {
    let snapshot = createSnapshot()
    let dataSnapshot = UIImageJPEGRepresentation(snapshot, 1.0)
      let messageController = MFMessageComposeViewController()
      messageController.messageComposeDelegate = self
      messageController.recipients = ["Recipient"]
      messageController.subject = "Send Quote"
      messageController.body = "Quote of the Day!"
      messageController.addAttachmentData(dataSnapshot!, typeIdentifier: "public.data", filename: "quote.jpg")
    if MFMessageComposeViewController.canSendText()
    {
      present(messageController, animated: true)
    }
  }
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
  {
    controller.dismiss(animated: true)
  }
  
  
  // MARK: View Methods
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
    let viewHeightConstraint = loadedNib.heightAnchor.constraint(equalToConstant: view.frame.height/2)
    viewHeightConstraint.isActive = true
    
  }
  
  func createSnapshot() -> UIImage
  {
    UIGraphicsBeginImageContextWithOptions(loadedNib.bounds.size, loadedNib.isOpaque, 0.0)
    loadedNib.drawHierarchy(in: loadedNib.bounds, afterScreenUpdates: false)
    let snapshot = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return snapshot!
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
}
