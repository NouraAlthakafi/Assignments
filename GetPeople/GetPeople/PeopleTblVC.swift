//
//  ViewController.swift
//  GetPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit

class PeopleTblVC: UITableViewController {
    //MARK: - Variables
    let peopleAPI = "https://swapi.py4e.com/api/people/"
    let cellID = "cellName"
    var arrayPeopleAPI: [APIPeopleStruct] = []
    var RED = UIColor.red
    var BLACK = UIColor.black
    var WHITE = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeopleAPI()
        tableView.reloadData()
    }
    
    //MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPeopleAPI.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = arrayPeopleAPI[indexPath.row].name
        cell.textLabel?.textColor = WHITE
        cell.backgroundColor = BLACK
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = RED
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = BLACK
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    //MARK: - Functions
    func getPeopleAPI() {
        let urlSession = URLSession.shared
        guard let urlPeople = URL.init(string: peopleAPI) else { return }
        print("1. Before API call:")
        let getAPITask = urlSession.dataTask(with: urlPeople) { data, response, error in
            print("2. During API call:")
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
            } else {
                self.parseLogic(data: data!)
            }
        }
        getAPITask.resume()
        print("3. After API call:")
    }
    
    func parseLogic(data: Data) {
        do {
            let dictPeople = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            if let results = dictPeople["results"] as? [[String: Any]] {
                for result in results {
                    parsePeopleAPI(dictPeople: result)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func parsePeopleAPI(dictPeople: [String: Any]) {
        guard let name = dictPeople["name"] as? String else { return }
        let apiPeople = APIPeopleStruct.init(name: name)
        arrayPeopleAPI.append(apiPeople)
        print(apiPeople)
    }
}

//MARK: - Struct
struct APIPeopleStruct {
    let name: String
}
