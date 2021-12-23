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
    var cellID = "cellName"
    var arrayPeopleAPI: APIResultPeople?
    var BLACK = UIColor.black
    var RED = UIColor.red
    var WHITE = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeopleAPI()
    }
    
    //MARK: - ViewWillAppear - TabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.barTintColor = .blue
        self.tabBarController?.tabBar.backgroundColor = .yellow
        self.tabBarController?.tabBar.unselectedItemTintColor = BLACK
        self.tabBarController?.tabBar.tintColor = RED
    }
    
    //MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPeopleAPI?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PeopleCustomCell
        cell.lbName.text = self.arrayPeopleAPI?.results[indexPath.row].name
        cell.lbGenber.text = self.arrayPeopleAPI?.results[indexPath.row].gender
        cell.lbBirthYear.text = self.arrayPeopleAPI?.results[indexPath.row].birth_year
        cell.lbMass.text = self.arrayPeopleAPI?.results[indexPath.row].mass
        cell.lbName.textColor = WHITE
        cell.lbGenber.textColor = WHITE
        cell.lbBirthYear.textColor = WHITE
        cell.lbMass.textColor = WHITE
        cell.backgroundColor = BLACK
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = RED
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    //MARK: - Functions
    func getPeopleAPI() {
        APImanager.getAPIResponse(urlPath: peopleAPI) { data, error in
            if error != nil {
                print("Error \(String(describing: error?.localizedDescription))")
            } else {
                if let data = data {
                   let namePeople = self.parseLogic(data: data)
                    self.arrayPeopleAPI = namePeople
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func parseLogic(data: Data) -> APIResultPeople? {
        do {
            let dictPeople = try JSONDecoder().decode(APIResultPeople.self, from: data)
            //print("\(dictPeople)")
            print(dictPeople.results.first!.name)
            return dictPeople
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

//MARK: - Structs
struct APIResultPeople: Codable {
    let results: [APIPeopleStruct]
}

struct APIPeopleStruct: Codable {
    let name: String
    let gender: String
    let birth_year: String
    let mass: String
}
