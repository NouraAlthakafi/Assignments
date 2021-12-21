//
//  ViewController.swift
//  TodoList
//
//  Created by admin on 19/12/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tfTaskTitle: UITextField!
    @IBOutlet weak var tvTaskDescription: UITextView!
    @IBOutlet weak var dpTaskTime: UIDatePicker!
    
    //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjSave = (UIApplication.shared.delegate as! AppDelegate).saveContext
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        let task = TodoListItem(context: context)
        task.taskTitle = tfTaskTitle.text ?? "Task Title"
        task.taskDescription = tvTaskDescription.text
        task.taskDate = dpTaskTime.date
        
        // Save user task
        do {
            try context.save()
        } catch {
            print(error)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}
