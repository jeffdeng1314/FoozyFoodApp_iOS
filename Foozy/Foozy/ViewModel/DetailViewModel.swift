//
//  NetworkManager.swift
//  Foozy
//
//  Created by Jeff Deng on 1/9/23.
//

import Foundation
import SwiftUI

struct DetailViewModel {
    // Storing all the fetched cards here
    
    let apiKey: String
    let headers: [String : String]
    let url: String
    var location: String?
    var latitutde: String?
    var longitude: String?
    var queryLimit: Int?

    init() {
        
        apiKey = (Bundle.main.infoDictionary?["YELP_API_KEY"] as? String)!
        
        headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        queryLimit = 1
        
        url = "https://api.yelp.com/v3/businesses/search?sort_by=best_match&limit=\(queryLimit!)"
        
        let _ = print("headers: \(headers)")
    }
    
    
    func fetchYelpBusinesses(cityName: String) -> [Card]? {
        let urlString = "\(url)&location=\(cityName)"
        print("urlString: \(urlString)")
        return performRestRequest(with: urlString)
    }
    
    
    private func performRestRequest(with yelpUrl: String) -> [Card]? {
        var result: [Card]?
        
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
                    return
                }
                
                if let safeData = data {
                    if let cards = self.parseJSON(safeData){
                        result = cards
                    }
                }
                
//                let httpResponse = response as? HTTPURLResponse
//                  print(httpResponse!)
              
            })
            
            dataTask.resume()
            
            return result
        }
        else {
            print("url not working....")
            return nil
        }
    }
    
    
    private func parseJSON(_ businessesData: Data) -> [Card]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(BusinessesData.self, from: businessesData)
            var cards: [Card] = []
            
            for business in decodedData.businesses {
                var categories: [String] = []
                for each in business.categories {
                    // getting all of the categories into a string list
                    categories.append(each.title)
                }
                
                let card = Card(businessId: business.id, name: business.name, image:
                                    business.image_url, rating: business.rating, reviewCounts: business.review_count, categories: categories )
                
                cards.append(card)
            }
            print("!!!fetched cards: \(cards)\n")
            return cards
            
        } catch {
            print("Error while parsing JSON... error=\(error)")
        }
        return nil
    }
}
