//
//  TableViewController.swift
//  Bucket List
//
//  Created by admin on 16/12/2021.
//

import UIKit

class BucketListTableViewController: UITableViewController, DelegateSaveBtn {
    var userBucketList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBucketList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBucketItem", for: indexPath)
        cell.textLabel?.text = userBucketList[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddToListTableViewController
            addItemTableController.delegate = self
        } else if sender is NSIndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddToListTableViewController
            addItemTableController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let bucketItem = userBucketList[indexPath.row]
            
            addItemTableController.editBucketItem = bucketItem
            addItemTableController.indexPath = indexPath
        }
    }
    
    func canceling(by controller: AddToListTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saving(by controller: AddToListTableViewController, with newBucketItem: String, at indexPath: NSIndexPath?) {
        if let indexPath = indexPath {
            userBucketList[indexPath.row] = newBucketItem
        } else {
            userBucketList.append(newBucketItem)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditBucketItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        userBucketList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}
