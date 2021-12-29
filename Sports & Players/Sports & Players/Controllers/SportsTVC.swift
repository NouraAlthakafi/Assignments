//
//  ViewController.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData

class SportsTVC: UITableViewController {
    
    // MARK: - Variables
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arraySports = [SportsEntity]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllSports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Actions
    @IBAction func btnAddSport(_ sender: UIBarButtonItem) {
        alertAddSport()
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSport", for: indexPath) as! SportsCustomCell
        cell.lbSport.text = arraySports[indexPath.row].sportName
        
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        alertUpdateSport()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // move to players page
    }
    
    // delete method
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sport = arraySports[indexPath.row]
                managedObjectContext.delete(sport)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("\(error.localizedDescription)")
                }
                arraySports.remove(at: indexPath.row)
                tableView.reloadData()
    }
    
    // MARK: - AlertDialogs
    func alertAddSport() {
        let addSportAlert = UIAlertController(title: "New Sport", message: "Add a new sport", preferredStyle: .alert)
        // text field
        addSportAlert.addTextField(configurationHandler: nil)
        let tfSport =  addSportAlert.textFields![0]
        tfSport.placeholder = "Enter a sport"
        // Buttons
        // save
        let btnSaveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let sport = SportsEntity.self(context: self.managedObjectContext)
            sport.sportName = tfSport.text!
            self.tableView.reloadData()
            do {
                try self.managedObjectContext.save()
                print("Success!")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            self.fetchAllSports()
        }
        
        // cancel
        let btnCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addSportAlert.addAction(btnSaveAction)
        addSportAlert.addAction(btnCancelAction)
        
        present(addSportAlert, animated: true, completion: nil)
    }
    
    func alertUpdateSport() {
        let updateSportAlert = UIAlertController(title: "Edit Sport", message: "Edit sport", preferredStyle: .alert)
        // text field
        updateSportAlert.addTextField(configurationHandler: nil)
        let tfSport =  updateSportAlert.textFields![0]
        tfSport.text = "old sport"
        
        // Buttons Action
        // save update
        let btnSaveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
        }
        
        // cancel
        let btnCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        updateSportAlert.addAction(btnSaveAction)
        updateSportAlert.addAction(btnCancelAction)
        
        present(updateSportAlert, animated: true, completion: nil)
    }
    
    // MARK: - CoreData Function
    func fetchAllSports() {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SportsEntity")
            do {
                let result = try managedObjectContext.fetch(request)
                arraySports = result as! [SportsEntity]
            } catch {
                print("\(error.localizedDescription)")
            }
        }
}
