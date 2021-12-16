//
//  UserWordsViewController.swift
//  MadLips
//
//  Created by admin on 16/12/2021.
//

import UIKit

class UserWordsViewController: UIViewController {
    @IBOutlet weak var tfAdjective: UITextField!
    @IBOutlet weak var tfVerb1: UITextField!
    @IBOutlet weak var tfVerb2: UITextField!
    @IBOutlet weak var tfNoun: UITextField!
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        performSegue(withIdentifier: "segueMadLips", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fullSentence = segue.destination as! ViewController
        fullSentence.adjectiveWord = tfAdjective.text
        fullSentence.verb1Word = tfVerb1.text
        fullSentence.verb2Word = tfVerb2.text
        fullSentence.nounWord = tfNoun.text
    }*/
}
