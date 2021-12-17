//
//  TableViewController.swift
//  Bucket List
//
//  Created by admin on 16/12/2021.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, DelegateSaveBtn {
    var userBucketList = [BucketListItemList]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchaAllItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBucketList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBucketItem", for: indexPath)
        cell.textLabel?.text = userBucketList[indexPath.row].newBucketItem!

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddToListTableViewController
            addItemTableController.delegate = self
        } else if sender is IndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableController = navigationController.topViewController as! AddToListTableViewController
            addItemTableController.delegate = self
            let indexPath = sender as! IndexPath
            let bucketItem = userBucketList[indexPath.row]
            
            addItemTableController.editBucketItem = bucketItem.newBucketItem!
            addItemTableController.indexPath = indexPath
        }
    }
    
    func canceling(by controller: AddToListTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saving(by controller: AddToListTableViewController, with newBucketItem: String, at indexPath: IndexPath?) {
        if let iP = indexPath {
            let item = userBucketList[iP.row]
            item.newBucketItem = newBucketItem
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItemList", into: managedObjectContext) as! BucketListItemList
            item.newBucketItem = newBucketItem
            userBucketList.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditBucketItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = userBucketList[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        userBucketList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func fetchaAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItemList")
        do {
            let result = try managedObjectContext.fetch(request)
            userBucketList = result as! [BucketListItemList]
        } catch {
            print("\(error)")
        }
    }
    
}
