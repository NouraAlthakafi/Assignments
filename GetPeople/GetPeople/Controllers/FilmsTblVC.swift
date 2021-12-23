//
//  FilmsTblVC.swift
//  GetPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmsTblVC: UITableViewController {
    //MARK: - Variables
    let cellID = "cellTitle"
    var arrayFilmsAPI: APIResultFilms?
    var BLUE = UIColor.blue
    var BLACK = UIColor.black
    var YELLOW = UIColor.yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmsAPI()
        tableView.backgroundColor = BLUE
    }
    
    //MARK: - ViewWillAppear - TabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.unselectedItemTintColor = .black
        self.tabBarController?.tabBar.tintColor = .blue
    }

    // MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFilmsAPI?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = self.arrayFilmsAPI?.results[indexPath.row].title
        cell.textLabel?.textColor = YELLOW
        cell.backgroundColor = BLUE
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = YELLOW
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = BLUE
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    //MARK: - Functions
    func getFilmsAPI() {
        let filmsAPI = "https://swapi.dev/api/films/"
        APImanager.getAPIResponse(urlPath: filmsAPI) { data, error in
            if error != nil {
                print("Error \(String(describing: error?.localizedDescription))")
            } else {
                if let data = data {
                   let titleFilms = self.parseLogic(data: data)
                    self.arrayFilmsAPI = titleFilms
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func parseLogic(data: Data) -> APIResultFilms? {
        do {
            let dictFilms = try JSONDecoder().decode(APIResultFilms.self, from: data)
            //print("\(dictFilms)")
            print(dictFilms.results.first!.title)
            return dictFilms
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

//MARK: - Structs
struct APIResultFilms: Codable {
    let results: [APIFilmsStruct]
}

struct APIFilmsStruct: Codable {
    let title: String
}
