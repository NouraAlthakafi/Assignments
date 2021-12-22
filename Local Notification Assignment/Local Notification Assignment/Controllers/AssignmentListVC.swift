//
//  ViewController.swift
//  Local Notification Assignment
//
//  Created by admin on 21/12/2021.
//

import UIKit

class AssignmentListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, AddTrackerDelegate {
    //MARK: - Outlets
    @IBOutlet weak var tblAssignmentList: UITableView!
    
    //MARK: - Variables
    let cellID = "cellAssignment"
    var trackerArray: [Tracker] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tblAssignmentList.dataSource = self
        tblAssignmentList.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func brbtnGoAddAssignment(_ sender: UIBarButtonItem) {
        let addAssignmentVC = storyboard?.instantiateViewController(withIdentifier: "AddAssignmentViewController") as! AddAssignmentVC
        addAssignmentVC.delegate = self
        self.navigationController?.pushViewController(addAssignmentVC, animated: true)
    }
    
    // MARK: - DataSource of TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let tracker = trackerArray[indexPath.row]
        cell.textLabel?.text = tracker.assignmentName
        cell.detailTextLabel?.text = String(tracker.timerInterval)
        return cell
    }
    
    //MARK: - Delegate of TableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignmentTimerVC = storyboard?.instantiateViewController(withIdentifier: "AssignmentTimerViewController") as! AssignmentTimerVC
        assignmentTimerVC.tracker = trackerArray[indexPath.row]
        self.navigationController?.pushViewController(assignmentTimerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        trackerArray.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    //MARK: - AddTrackerDelegate Protocol
    func addTrackerToList(tracker: Tracker) {
        trackerArray.append(tracker)
        tblAssignmentList.reloadData()
    }
}

