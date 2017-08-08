//
//  QPTableViewController.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import RealmSwift

class QPTableViewController: UITableViewController {
  
  let realm = try! Realm()
  var listOfQuotes: Results<Quote>!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    //    return listOfQuotes.count
    return 5
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QPTableViewCell
    
    // Configure the cell...
    //    cell.quote = listOfQuotes.first
    
    return cell
  }
  
  
  // MARK: Segue Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    performSegue(withIdentifier: "detailSegue", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if (segue.description == "detailSegue")
    {
      let dvc = segue.destination as! QPDetailViewController
      print(dvc.description)
    }
  }
  
  // MARK: Table Edit Methods
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    
  }
  
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
  }
  
  
}
