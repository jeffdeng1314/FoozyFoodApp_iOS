//
//  NetworkManager.swift
//  Foozy
//
//  Created by Jeff Deng on 1/9/23.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    // Storing all the fetched cards here
    
    @Published var isLoading: Bool = true
    @Published var detail: BusinessDetail?
    
    func fetchYelpBusinessDetail(card: Card) {
        let urlString = Constants.API_URL_GET_BUSINESS_BY_ID + card.businessId
        performRestRequest(with: urlString, card: card)
    }
    
    private func performRestRequest(with yelpUrl: String, card: Card) {
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
                    if let details = self?.parseJSON(businessesDetailData: safeData, card: card){
                        DispatchQueue.main.async {
                            self?.detail = details
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
    
    
    private func parseJSON(businessesDetailData: Data, card: Card) -> BusinessDetail? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(BusinessDetailData.self, from: businessesDetailData)
            
            let phone = Phone(number: decodedData.phone, displayPhone: decodedData.display_phone)
            var hours: [Hour] = []
            
            for each in decodedData.hours {
                var schedules: [Schedule] = []
                for day in each.open {
                     let x = Schedule(isOvernight: day.is_overnight, start: day.start, end: day.end, day: day.day)
                    schedules.append(x)
                }
                let hour = Hour(open: schedules, isOpenNow: each.is_open_now)
                hours.append(hour)
            }
            
            let xyLocation: Coordinate = Coordinate(latitude: decodedData.coordinates.latitude, longitude: decodedData.coordinates.longitude)
            
            
            let businessDetail = BusinessDetail(name: card.name, phone: phone, reviews: nil, image: card.image, photos: decodedData.photos, price: decodedData.price, hours: hours, categories: card.categories, coordinate: xyLocation, address: decodedData.location.display_address, url: decodedData.url, isClosed: decodedData.is_closed)

            return businessDetail
            
        } catch {
            print("Error while parsing JSON... error=\(error)")
        }
        return nil
    }
}
