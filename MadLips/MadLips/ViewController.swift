//
//  ViewController.swift
//  MadLips
//
//  Created by admin on 16/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbSentence: UILabel!
    
    var adjectiveWord: String = ""
    var verb1Word: String = ""
    var verb2Word: String = ""
    var nounWord: String = ""
    var userWords: [String] = []
    //let fullSentence = lbSentence.text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is UserWordsViewController {
            let userWord = unwindSegue.source as! UserWordsViewController
            if let adj = userWord.tfAdjective.text {
                adjectiveWord = adj
                userWords.append(adjectiveWord)
            }
            if let v1 = userWord.tfVerb1.text {
                verb1Word = v1
                userWords.append(verb1Word)
            }
            if let v2 = userWord.tfVerb2.text {
                verb2Word = v2
                userWords.append(verb2Word)
            }
            if let n = userWord.tfNoun.text {
                nounWord = n
                userWords.append(nounWord)
            }
            lbSentence.text = "We are having a perfectly \(userWords[0]) time now. Later, we will \(userWords[1]) and \(userWords[2]) in the \(userWords[3])."
        }
    }
}
