//
//  ViewController.swift
//  Binary Counter
//
//  Created by admin on 14/12/2021.
//
import Foundation
import UIKit

protocol BinaryCounterTBVCD: class {
    func addToNumericValue(numericValue: Int)
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var lbNumber: UILabel!
    
    var delegate: BinaryCounterTBVCD?
    
    @IBAction func btnAction(_ sender: UIButton) {
        var numericValue = Int(lbNumber!.text!)
        if sender.tag == 1 {
            numericValue = -numericValue!
        }
        delegate?.addToNumericValue(numericValue: numericValue!)
    }
}

class ViewController: UIViewController, UITableViewDataSource, BinaryCounterTBVCD {
    @IBOutlet weak var tbvNumbers: UITableView!
    @IBOutlet weak var lbTotal: UILabel!
    
    var numbersArray = [String]()
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tbvNumbers.dataSource = self
        tbvNumbers.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvNumbers.dequeueReusableCell(withIdentifier: "cellNumber", for: indexPath) as! CustomCell
        cell.delegate = self
        cell.lbNumber.text = String(describing: pow(10, indexPath.row))
        
        return cell
    }
    
    func addToNumericValue(numericValue: Int) {
        total += numericValue
        lbTotal.text = "Total: \(total)"
    }
}

