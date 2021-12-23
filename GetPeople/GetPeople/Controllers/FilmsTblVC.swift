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
    var arrayFilmsAPI: APIResultFilms?
    var BLACK = UIColor.black
    var BLUE = UIColor.blue
    var WHITE = UIColor.white
    var YELLOW = UIColor.yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmsAPI()
        tableView.backgroundColor = BLUE
    }
    
    //MARK: - ViewWillAppear - TabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.barTintColor = BLACK
        self.tabBarController?.tabBar.backgroundColor = .red
        self.tabBarController?.tabBar.unselectedItemTintColor = WHITE
        self.tabBarController?.tabBar.tintColor = YELLOW
    }

    // MARK: - TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFilmsAPI?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FilmsCustomCell
        cell.lbTitle.text = self.arrayFilmsAPI?.results[indexPath.row].title
        cell.lbReleaseDate.text = self.arrayFilmsAPI?.results[indexPath.row].release_date
        cell.lbDirector.text = self.arrayFilmsAPI?.results[indexPath.row].director
        cell.lbOpeningCrawl.text = self.arrayFilmsAPI?.results[indexPath.row].opening_crawl
        cell.lbTitle.textColor = .red
        cell.lbReleaseDate.textColor = .red
        cell.lbDirector.textColor = .red
        cell.lbOpeningCrawl.textColor = .red
        cell.backgroundColor = BLUE
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = YELLOW
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    //MARK: - Functions
    func getFilmsAPI() {
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
    let release_date: String
    let director: String
    let opening_crawl: String
}
