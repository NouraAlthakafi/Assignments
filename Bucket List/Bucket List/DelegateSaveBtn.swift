//
//  DelegateSaveBtn.swift
//  Bucket List
//
//  Created by admin on 16/12/2021.
//

import Foundation
import UIKit

protocol DelegateSaveBtn: class {
    func saving(by controller: AddToListTableViewController, with newBucketItem: String, at indexPath: NSIndexPath?)
    func canceling(by controller: AddToListTableViewController)
}
