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
  var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    listOfQuotes = realm.objects(Quote.self)
    
    notificationToken = listOfQuotes.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
      guard let tableView = self?.tableView else { return }
      switch changes {
      case .initial:
        tableView.reloadData()
        break
      case .update(_, let deletions, let insertions, let modifications):
        // Query results have changed, so apply them to the UITableView
        tableView.beginUpdates()
        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                             with: .automatic)
        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.endUpdates()
        break
      case .error(let error):
        fatalError("\(error)")
        break
      }
    })
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return listOfQuotes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QPTableViewCell
    
    // Configure the cell...
    cell.quote = listOfQuotes[indexPath.row]
    
    return cell
  }
  
  
  
  // MARK: Segue Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    performSegue(withIdentifier: "detailSegue", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if (segue.identifier == "detailSegue")
    {
      let indexPath = sender as! IndexPath
      let dvc = segue.destination as! QPDetailViewController
      dvc.quote = listOfQuotes[indexPath.row]
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
      
//      tableView.deleteRows(at: [indexPath], with: .fade)
      try! realm.write {
        realm.delete(listOfQuotes[indexPath.row])
      }
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
