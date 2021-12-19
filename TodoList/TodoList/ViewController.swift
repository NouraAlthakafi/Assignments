//
//  ViewController.swift
//  TodoList
//
//  Created by admin on 19/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfTaskTitle: UITextField!
    @IBOutlet weak var tvTaskDescription: UITextView!
    @IBOutlet weak var dpTaskTime: UIDatePicker!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjSave = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        let task = TodoListItem(context: managedObjectContext)
        task.taskTitle = tfTaskTitle.text
        task.taskDescription = tvTaskDescription.text
        task.taskDate = dpTaskTime.date
        // Save user task
        managedObjSave()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
