//
//  TableViewController.swift
//  Bucket List
//
//  Created by admin on 16/12/2021.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController, DelegateSaveBtn {
    var userBucketList = [Task]()
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        override func viewDidLoad() {
            super.viewDidLoad()
            callingAPI()
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userBucketList.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBucketItem", for: indexPath)
            cell.textLabel?.text = userBucketList[indexPath.row].objective
            cell.detailTextLabel?.text = userBucketList[indexPath.row].created_at

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
                
                addItemTableController.editBucketItem = bucketItem.objective
                addItemTableController.indexPath = indexPath
            }
        }
        
        func canceling(by controller: AddToListTableViewController) {
            dismiss(animated: true, completion: nil)
        }
        
        func saving(by controller: AddToListTableViewController, with newBucketItem: String, at indexPath: IndexPath?) {
            if let iP = indexPath {
                APIManager.updatingTask(id: iP, objective: newBucketItem, completionHandler: { data, response, error in
                    do {
                        guard let data = data else { return }
                        let result = try JSONDecoder().decode([Task].self, from: data)
                        self.userBucketList = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                })
            } else {
                APIManager.addingTask(objective: newBucketItem, completionHandler: { data, response, error in
                    do {
                        guard let data = data else { return }
                        let result = try JSONDecoder().decode([Task].self, from: data)
                        self.userBucketList = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                })
            }
            dismiss(animated: true, completion: nil)
        }
        
        override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            performSegue(withIdentifier: "EditBucketItemSegue", sender: indexPath)
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            APIManager.deletingTask(id: userBucketList[indexPath.row].id, completionHandler: { data, response, error in
                do {
                    guard let data = data else { return }
                    let result = try JSONDecoder().decode([Task].self, from: data)
                    self.userBucketList = result
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    
    func callingAPI() {
        APIManager.getAPITasks(completionHandler: { data, response, error in
            do{
                guard let data = data else { return }
                self.userBucketList = try JSONDecoder().decode([Task].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        })
    }
}
