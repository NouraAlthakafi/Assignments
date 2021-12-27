//
//  TaskStruct.swift
//  Bucket List
//
//  Created by admin on 27/12/2021.
//

import Foundation

struct Task: Codable {
    var id: IndexPath
    var objective: String
    var created_at: String
}
