//
//  APImanager.swift
//  GetPeople
//
//  Created by admin on 23/12/2021.
//

import Foundation

class APImanager {
    class func getAPIResponse(urlPath: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let urlSession = URLSession.shared
        guard let url = URL.init(string: urlPath) else { return }
        print("1. Before API call:")
        let getAPITask = urlSession.dataTask(with: url) { data, response, error in
            print("2. During API call:")
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
                completionHandler(nil, error)
            } else {
                completionHandler(data, nil)
            }
        }
        getAPITask.resume()
        print("3. After API call:")
    }
}
