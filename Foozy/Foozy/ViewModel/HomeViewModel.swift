//
//  CardData.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var displayBusinesses: [Card] = []
    @Published var fetchedBusinesses: [Card]? = []
    @Published var isLoading: Bool = true
    
    let apiKey: String
    let headers: [String : String]
    let url: String
    var location: String?
    var latitutde: String?
    var longitude: String?
    var queryLimit: Int?
    var categories: String?
    
    init() {
        apiKey = (Bundle.main.infoDictionary?["YELP_API_KEY"] as? String)!
        
        headers = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        queryLimit = 30
        
        categories = "food,foodtrucks,bubbletea"
        
        url = "https://api.yelp.com/v3/businesses/search?sort_by=best_match&categories=\(categories!)&limit=\(queryLimit!)"
        
//        fetchedBusinesses = [
//            Card(businessId: "123", name: "Sakura Noodle House", image: "https://s3-media2.fl.yelpcdn.com/bphoto/oWB3Ph9n8bx7tNQ7mhrEzQ/o.jpg", rating: 4.5, categories: ["Ramen, Noodle, Food Trucks"]),
//            Card(businessId: "456", name: "Bobablastic", image: "https://s3-media1.fl.yelpcdn.com/bphoto/tHEQNUQm8COZ9r0mXPAj_A/o.jpg", rating: 2.5, categories: ["Bubble Tea, Coffee & Tea, Food Trucks"])
//        ]
       
    }
    
    
    func updateBusinesses(card business: Card) {
        print("card: \(business.name)")
        
        
        let displayBusinessId = displayBusinesses.last?.businessId
        
        print("id: \(displayBusinessId!) <-> lastId: \(displayBusinesses.last!.businessId)")
        
        if business.businessId == displayBusinessId {
            print("equal! Removed!")
            displayBusinesses.removeLast()
        }
        else {
            print("not equal, not removing elements")
        }
    }
    
    func fetchYelpBusinesses(cityName: String) {
        let urlString = "\(url)&location=\(cityName)"
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
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                    return
                }
                
                if let safeData = data {
                    if let cards = self?.parseJSON(safeData){
                        DispatchQueue.main.async {
                            let merged = cards + self!.displayBusinesses
                            self?.displayBusinesses = merged.reversed()
                            self!.isLoading = false
                        }
                        return
                    }
                }
                
//                let httpResponse = response as? HTTPURLResponse
//                  print(httpResponse!)
              
            })
            
            dataTask.resume()

        }
        else {
            print("url not working....")
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
            
            return cards
            
        } catch {
            print("Error while parsing JSON... error=\(error)")
        }
        return nil
    }
}

