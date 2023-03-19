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
    
    func updateBusinesses(card business: Card) {
        print("card: \(business.name)")
        
        
        let displayBusinessId = displayBusinesses.last?.businessId
        
        if business.businessId == displayBusinessId {
            print("equal! Removed!")
            displayBusinesses.removeLast()
        }
        else {
            print("not equal, not removing elements")
        }
    }
    
    func fetchYelpBusinesses(cityName: String? = nil, latitude: Double = 0, longitude: Double = 0 ) {
        var urlString = ""
        
        if cityName != nil {
            urlString = Constants.API_URL_SEARCH_BUSINESS_USING_LOCATION(location: cityName!)
        } else {
            urlString = Constants.API_URL_SEARCH_BUSINESS_USING_COORDINATES(latitude: latitude, longitude: longitude)
        }
        
        print("fetching yelp businesses: cityName=\(cityName), lat=\(latitude), lon=\(longitude)")
        
        performRestRequest(with: urlString)
    }
    
    private func performRestRequest(with yelpUrl: String) {
        if let url = URL(string: yelpUrl) {
            
            let request = NSMutableURLRequest(url: url,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            
            request.httpMethod = Constants.REQUEST_METHOD_GET
            request.allHTTPHeaderFields = Constants.HEADERS

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
                
                let card = Card(
                    businessId: business.id,
                    name: business.name,
                    image: business.image_url,
                    rating: business.rating,
                    reviewCounts: business.review_count,
                    categories: categories
                )
                
                cards.append(card)
            }
            
            return cards
            
        } catch {
            print("Error while parsing JSON... error=\(error)")
        }
        return nil
    }
    
    func setIsLoadingValue(_ loading: Bool) {
        self.isLoading = loading
        print("loading: \(self.isLoading)")
    }
}

