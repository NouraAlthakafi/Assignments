//
//  APIManager.swift
//  Bucket List
//
//  Created by admin on 27/12/2021.
//

import Foundation

class APIManager {
    static func getAPITasks(completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let url = "https://saudibucketlistapi.herokuapp.com/tasks/"
        let getTasks = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: completionHandler)
            getTasks.resume()
    }
    
    static func addingTask(objective:String, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let url = "https://saudibucketlistapi.herokuapp.com/tasks/"
        var requestMethod = URLRequest(url: URL(string: url)!)
        requestMethod.httpMethod = "POST"
        let obj = "objective = \(objective)"
        requestMethod.httpBody = obj.data(using: .utf8)
        
        let postTask = URLSession.shared.dataTask(with: requestMethod, completionHandler: completionHandler)
            postTask.resume()
    }
    
    static func updatingTask(id:IndexPath, objective:String, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let url = "https://saudibucketlistapi.herokuapp.com/tasks/"
        var requestMethod = URLRequest(url: URL(string: "\(url)\(id)")!)
        requestMethod.httpMethod = "PATCH"
        let obj = ["objective": objective]
        do {
            requestMethod.httpBody = try JSONSerialization.data(withJSONObject: obj)
        } catch {
            print(error.localizedDescription)
        }
        
        requestMethod.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let updateTask = URLSession.shared.dataTask(with: requestMethod, completionHandler: completionHandler)
            updateTask.resume()
    }
    
    static func deletingTask(id:IndexPath, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let url = "https://saudibucketlistapi.herokuapp.com/tasks/"
        var requestMethod = URLRequest(url: URL(string: "\(url)\(id)")!)
        requestMethod.httpMethod = "DELETE"
        let deleteTask = URLSession.shared.dataTask(with: requestMethod, completionHandler: completionHandler)
            deleteTask.resume()
    }
}
