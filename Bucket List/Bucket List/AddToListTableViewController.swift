//
//  AddToListTableViewController.swift
//  Bucket List
//
//  Created by admin on 16/12/2021.
//

import UIKit

class AddToListTableViewController: UITableViewController {
    @IBOutlet weak var tfAddBucketItem: UITextField!
    
    weak var delegate: DelegateSaveBtn?
    var editBucketItem: String?
    var indexPath: NSIndexPath?
    
    @IBAction func btnCancelAction(_ sender: UIBarButtonItem) {
        delegate?.canceling(by: self)
    }
    
    @IBAction func btnSaveAction(_ sender: UIBarButtonItem) {
        let newBucketItem = tfAddBucketItem.text!
        delegate?.saving(by: self, with: newBucketItem, at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfAddBucketItem.text = editBucketItem

    }
    
}
