
//  QPAddViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class QPAddViewController: UIViewController {
  
  @IBOutlet weak var nibView: QuoteView!
  var viewHeightConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    addQuoteView()
  }
  
  @IBAction func cancelButton(_ sender: UIBarButtonItem)
  {
    dismiss(animated: true)
  }
  @IBAction func saveButton(_ sender: UIBarButtonItem)
  {
    dismiss(animated: true)
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func addQuoteView()
  {
    let loadedNib = Bundle.main.loadNibNamed("QuoteView", owner: nil)?.first as! QuoteView
    loadedNib.authorLabel.text = "Author"
    loadedNib.quoteLabel.text = "Quote"
    loadedNib.imageView.image = UIImage.init(named: "image")
    view.addSubview(loadedNib)
    
    loadedNib.translatesAutoresizingMaskIntoConstraints = false
    loadedNib.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    loadedNib.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    loadedNib.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    viewHeightConstraint = loadedNib.heightAnchor.constraint(equalToConstant: view.frame.height/2)
    viewHeightConstraint.isActive = true
    
  }
  
}
