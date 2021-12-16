//
//  DirectionViewController.swift
//  North East South West
//
//  Created by admin on 16/12/2021.
//

import UIKit

class DirectionViewController: UIViewController {
    @IBOutlet weak var btnDirection: UIButton!
    
    var directionRequired: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnDirection.setTitle(directionRequired, for: .normal)
    }
    
    @IBAction func btnDirectionAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
