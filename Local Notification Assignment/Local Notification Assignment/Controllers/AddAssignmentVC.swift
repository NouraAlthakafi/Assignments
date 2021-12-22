//
//  AddAssignmentViewController.swift
//  Local Notification Assignment
//
//  Created by admin on 21/12/2021.
//

import UIKit

class AddAssignmentVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var tfAssignmentName: UITextField!
    @IBOutlet weak var pvTimer: UIPickerView!
    
    //MARK: - Variables
    weak var delegate: AddTrackerDelegate?
    let timerGoals = ["5 minutes", "10 minutes", "20 Minutes", "30 minutes"]
    
    // MARK: - Actions
    @IBAction func btnAddAssignment(_ sender: UIButton) {
        guard let assignmentName = tfAssignmentName.text else { return }
        let selectedPickerViewIndex = pvTimer.selectedRow(inComponent: 1)
        let timerGoal = timerGoals[selectedPickerViewIndex]
        let timeInterval = calculateTimerValue(pickerViewTarget: timerGoal)
        
        let tracker = Tracker.init(assignmentName: assignmentName, timerInterval:timeInterval, timerDisplayValue: timerGoal)
        
        delegate?.addTrackerToList(tracker: tracker)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerView()

    }
    
    //MARK: - DataSource of PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timerGoals.count
    }
    
    //MARK: - Delegate of PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timerGoals[row]
    }
    
//MARK: - Functions
    func setUpPickerView() {
        pvTimer.dataSource = self
        pvTimer.delegate = self
    }
    
    func calculateTimerValue(pickerViewTarget: String) -> Int {
        var timeInterval = 0
        switch pickerViewTarget {
        case timerGoals[0]:
            timeInterval = 5 * 60
        case timerGoals[1]:
            timeInterval = 10 * 60
        case timerGoals[2]:
            timeInterval = 20 * 60
        case timerGoals[3]:
            timeInterval = 30 * 60
        default:
            timeInterval = 0
        }
        
        return timeInterval
    }
}

//MARK: - Protocols
protocol AddTrackerDelegate: NSObjectProtocol {
    func addTrackerToList(tracker: Tracker)
}
