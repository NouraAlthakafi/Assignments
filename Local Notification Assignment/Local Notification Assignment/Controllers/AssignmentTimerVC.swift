//
//  AssignmentTimerViewController.swift
//  Local Notification Assignment
//
//  Created by admin on 21/12/2021.
//

import UIKit

class AssignmentTimerVC: UIViewController, UNUserNotificationCenterDelegate {
//MARK: - Outlets
    @IBOutlet weak var lblAssignmentName: UILabel!
    @IBOutlet weak var lblDisplayTimer: UILabel!
    @IBOutlet weak var lblTimerGoal: UILabel!
    
    //MARK: - Variables
    var timer: Timer?
    var tracker: Tracker?
    var timerCount = 0
    weak var delegate: AddTrackerDelegate?
    
//MARK: - Actions
    @IBAction func btnTimerAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            timerCount = tracker?.timerInterval as! Int
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerValue), userInfo: nil, repeats: true)
            sender.setTitle("Cancel", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            scheduleNotification()
        } else {
            timerCount = 0
            timer?.invalidate()
            sender.setTitle("Start", for: .normal)
            sender.setTitleColor(.yellow, for: .normal)
            cancelTimerAndNotification()
        }
    }
    
    @objc func updateTimerValue() {
        if timerCount > 0 {
            lblDisplayTimer.text = String(timerCount) + " seconds"
            timerCount -= 1
        } else {
            //timer is over
            cancelTimerAndNotification()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAssignmentName.text = tracker?.assignmentName
        lblTimerGoal.text = tracker?.timerDisplayValue
    }

    //MARK: - Notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //notification arrived
        showAlert()
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    func userNotificationCenter(_center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        //notification clicked or opened
        print("Notification Received!")
    }
    
    //MARK: - Functions
    func scheduleNotification() {
        // scheduale the request.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        guard let tracker = tracker else { return }
        let request = NotificationManager.getNotificationRequest(tracker: tracker)
        center.add(request) { (error: Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            } else {
                print("Local Notification scheduled successfully!")
            }
        }
    }
    
    func removeNotification(identifier: String){
    }
    
    func cancelTimerAndNotification() {
        guard let identifier = tracker?.assignmentName else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        timerCount = 0
        timer?.invalidate()
        
        showCancelAlert()
    }
    
    //MARK: - Alerts
    func showAlert() {
        let alertVC = UIAlertController.init(title: tracker?.assignmentName, message: "You worked hard for \(String(describing: tracker?.timerDisplayValue))! Now, take a rest.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "Okay", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showCancelAlert() {
        let alertVC = UIAlertController.init(title: "Notification Cancelled", message: "Your Notification has been cancelled successfully", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "Okay", style: .cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}
