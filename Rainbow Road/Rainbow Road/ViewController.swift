//
//  ViewController.swift
//  Rainbow Road
//
//  Created by admin on 12/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let colorRainbowArray = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorRainbowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewRainbow.dequeueReusableCell(withIdentifier: "cellRainbow", for: indexPath)
        cell.backgroundColor = colorRainbowArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @IBOutlet weak var tableViewRainbow: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewRainbow.dataSource = self
        tableViewRainbow.delegate = self
        tableViewRainbow.reloadData()
    }


}

