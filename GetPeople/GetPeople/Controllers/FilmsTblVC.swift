//
//  FilmsTblVC.swift
//  GetPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmsTblVC: UITableViewController {
    //MARK: - Variables
    let filmsAPI = "https://swapi.dev/api/films/"
    let cellID = "cellTitle"
    var arrayFilmsAPI: [APIFilmsStruct] = []
    var BLUE = UIColor.blue
    var BLACK = UIColor.black
    var YELLOW = UIColor.yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmsAPI()
        tableView.reloadData()
        tableView.backgroundColor = BLUE
    }
    
    //MARK: - ViewWillAppear - TabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.backgroundColor = .yellow
        self.tabBarController?.tabBar.unselectedItemTintColor = .black
        self.tabBarController?.tabBar.tintColor = .blue
    }

    // MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFilmsAPI.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = arrayFilmsAPI[indexPath.row].title
        cell.textLabel?.textColor = YELLOW
        cell.backgroundColor = BLUE
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = YELLOW
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = BLACK
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    //MARK: - Functions
    func getFilmsAPI() {
        let urlSession = URLSession.shared
        guard let urlFilms = URL.init(string: filmsAPI) else { return }
        print("1. Before API call:")
        let getAPITask = urlSession.dataTask(with: urlFilms) { data, response, error in
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
            let dictFilms = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            if let results = dictFilms["results"] as? [[String: Any]] {
                for result in results {
                    parseFilmsAPI(dictFilms: result)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func parseFilmsAPI(dictFilms: [String: Any]) {
        guard let title = dictFilms["title"] as? String else { return }
        let apiFilms = APIFilmsStruct.init(title: title)
        DispatchQueue.main.async {
            self.arrayFilmsAPI.append(apiFilms)
            self.tableView.reloadData()
        }
        print(apiFilms)
    }
}

//MARK: - Struct
struct APIFilmsStruct: Codable {
    let title: String
}
