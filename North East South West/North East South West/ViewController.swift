//
//  ViewController.swift
//  North East South West
//
//  Created by admin on 16/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let direction = segue.destination as! DirectionViewController
        let certainDirection = sender as! UIButton
                if let certainDirection = certainDirection.titleLabel!.text {
                        direction.directionRequired = certainDirection
                }
    }
}
