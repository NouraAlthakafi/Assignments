//
//  TableViewController.swift
//  TodoList
//
//  Created by admin on 19/12/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjSave = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var userTasks = [TodoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchaAllTasks()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! TableViewCell
        let task = userTasks[indexPath.row]
        // The date of the task:
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .short
        let dateTask = date.string(from: task.taskDate!)
        cell.lbDate.text = dateTask
        // The task:
        cell.lbTitle.text = task.taskTitle
        cell.lbDescription.text = task.taskDescription
        // The accomplished task:
        if task.taskDone == true {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let task = userTasks[indexPath.row]
            task.taskDone = !task.taskDone
            if task.taskDone {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
        managedObjSave()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func fetchaAllTasks() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            userTasks = result as! [TodoListItem]
        } catch {
            print("\(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let task = userTasks[indexPath.row]
            managedObjectContext.delete(task)
            
            managedObjSave()
            
            userTasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
}
