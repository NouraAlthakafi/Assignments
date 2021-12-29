//
//  PlayersTVC.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//

import UIKit
import CoreData

class PlayersTVC: UITableViewController {
    
    // MARK: - Variables
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayPlayers = [PlayersEntity]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    // MARK: - Actions
    @IBAction func btnAddPlayer(_ sender: UIBarButtonItem) {
        alertAddPlayer()
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPlayers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPlayer", for: indexPath) as! PlayersCustomCell
        cell.lbName.text = arrayPlayers[indexPath.row].playerName
        cell.lbAge.text = "\(arrayPlayers[indexPath.row].playerAge)"
        cell.lbHeight.text = "\(arrayPlayers[indexPath.row].playerHeight)"
        
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        alertUpdatePlayer()
    }
    
    // delete method
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let player = arrayPlayers[indexPath.row]
                managedObjectContext.delete(player)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("\(error.localizedDescription)")
                }
                arrayPlayers.remove(at: indexPath.row)
                tableView.reloadData()
    }
    
    // MARK: - AlertDialogs
    func alertAddPlayer() {
        let addPlayerAlert = UIAlertController(title: "New Player", message: "Add a new player", preferredStyle: .alert)
        // text fields
        addPlayerAlert.addTextField(configurationHandler: nil)
        let tfPlayerName =  addPlayerAlert.textFields![0]
        tfPlayerName.placeholder = "Enter a player's name"
        let tfPlayerAge = addPlayerAlert.textFields![1]
        tfPlayerAge.placeholder = "Enter a player's age"
        let tfPlayerHeight = addPlayerAlert.textFields![2]
        tfPlayerHeight.placeholder = "Enter a player's height"
        
        // Buttons
        // save
        let btnSaveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let player = PlayersEntity.self(context: self.managedObjectContext)
            player.playerName = tfPlayerName.text!
            player.playerAge = Int16(tfPlayerAge.text!)
            player.playerHeight = Double(tfPlayerHeight.text!)
            self.tableView.reloadData()
            do {
                try self.managedObjectContext.save()
                print("Success!")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            self.fetchAllPlayers()
        }
        
        // cancel
        let btnCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addPlayerAlert.addAction(btnSaveAction)
        addPlayerAlert.addAction(btnCancelAction)
        
        present(addPlayerAlert, animated: true, completion: nil)
    }
    
    func alertUpdatePlayer() {
        let updatePlayerAlert = UIAlertController(title: "Edit Sport", message: "Edit sport", preferredStyle: .alert)
        // text fields
        updatePlayerAlert.addTextField(configurationHandler: nil)
        let tfPlayerName =  updatePlayerAlert.textFields![0]
        tfPlayerName.placeholder = "old name"
        let tfPlayerAge = updatePlayerAlert.textFields![1]
        tfPlayerAge.placeholder = "old age"
        let tfPlayerHeight = updatePlayerAlert.textFields![2]
        tfPlayerHeight.placeholder = "old height"
        
        // Buttons Action
        // save
        let btnSaveAction = UIAlertAction(title: "Save", style: .default) { _ in
            // coreData to save update
        }
        
        // cancel
        let btnCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        updatePlayerAlert.addAction(btnSaveAction)
        updatePlayerAlert.addAction(btnCancelAction)
        
        present(updatePlayerAlert, animated: true, completion: nil)
    }
    
    // MARK: - CoreData Function
    func fetchAllPlayers() {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayersEntity")
            do {
                let result = try managedObjectContext.fetch(request)
                arrayPlayers = result as! [PlayersEntity]
            } catch {
                print("\(error.localizedDescription)")
            }
        }
}
