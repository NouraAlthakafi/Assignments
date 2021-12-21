//
//  TableViewController.swift
//  TodoList
//
//  Created by admin on 19/12/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjSave = (UIApplication.shared.delegate as! AppDelegate).saveContext
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    var userTasks = [TodoListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchaAllTasks()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTasks.count
    }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! TableViewCell
        cell.lbTitle.text = userTasks[indexPath.row].taskTitle
        cell.lbDescription.text = userTasks[indexPath.row].taskDescription
        
        let task = userTasks[indexPath.row]
        // The date of the task:
        let date = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .short
        let dateTask = date.string(from: task.taskDate!)
        cell.lbDate.text = dateTask
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
        do {
            try context.save()
        } catch {
            print("\(error)")
            
        }
        //managedObjSave()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func fetchaAllTasks() {
        let request = NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
        do {
            userTasks = try context.fetch(request)
            //userTasks = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //tableView.reloadData()
        } catch {
            print("\(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let task = userTasks[indexPath.row]
            context.delete(task)
            
            userTasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
}
