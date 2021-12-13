//
//  ViewController.swift
//  Aging People
//
//  Created by admin on 12/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let cellIdentifier = "cellPeopleAge"
    let namesArray = ["Tareq", "Eman", "Abdulrahman", "Leena", "Abdullah", "Lama", "Noura", "Asmaa", "Urwah", "Mohammad", "Nada", "Abdulaziz"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPeopleList.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = namesArray[indexPath.row]
        for _ in namesArray.indices {
            let age = Int.random(in: 5...95)
            cell.detailTextLabel?.text = "\(age) years old"
        }
        return cell
    }
    
    @IBOutlet weak var tvPeopleList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvPeopleList.dataSource = self
        tvPeopleList.reloadData()
    }
}

