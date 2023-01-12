//
//  NetworkManager.swift
//  Foozy
//
//  Created by Jeff Deng on 1/9/23.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    // Storing all the fetched cards here
    @Published var fetchedBusinesses: [Card] = []
    
    let apiKey: String
    let headers: [String : String]
    let url: String
    var location: String?
    var latitutde: String?
    var longitude: String?
    var queryLimit: String?

    init() {
        // fetch the businesses
        fetchedBusinesses = [
            Card(businessId: "123", name: "Sakura Noodle House", image: "sakura-noodle-house", rating: 4.5, categories: ["Ramen, Noodle, Food Trucks"]),
            Card(businessId: "456", name: "Bobablastic", image: "bobablastic", rating: 2.5, categories: ["Bubble Tea, Coffee & Tea, Food Trucks"])
        ]
        
        apiKey = (Bundle.main.infoDictionary?["YELP_API_KEY"] as? String)!
        
        headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        queryLimit = "limit=20"
        
        url = "https://api.yelp.com/v3/businesses/search?sort_by=best_match&\(queryLimit!)"
        
        let _ = print("headers: \(headers)")
    }
    
    
    func fetchYelpBusinesses(cityName: String) {
        let urlString = "\(url)&location=\(cityName)"
        print("urlString: \(urlString)")
        performRestRequest(with: urlString)
    }
    
    private func performRestRequest(with yelpUrl: String) {
        if let url = URL(string: yelpUrl) {
            
            let request = NSMutableURLRequest(url: url,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil) {
                print(error as Any)
              } else {
                let httpResponse = response as? HTTPURLResponse
                  print(httpResponse!)
              }
            })
            
            dataTask.resume()
        }
        else {
            print("url not working....")
        }
    }
}
