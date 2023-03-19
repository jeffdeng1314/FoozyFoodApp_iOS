//
//  Constants.swift
//  Foozy
//
//  Created by Jeff Deng on 2/12/23.
//

import Foundation
import SwiftUI

struct Constants {
    
    static let YELP_API_KEY = (Bundle.main.infoDictionary?["YELP_API_KEY"] as? String)!
    
    static let HEADERS = [
        "accept": "application/json",
        "Authorization": "Bearer \(Constants.YELP_API_KEY)"
      ]
    
    static let REQUEST_METHOD_GET = "GET"
    
    static let CATEGORIES = "food,foodtrucks,bubbletea"
    
    static let QUERY_LIMIT = 30
    
    static func API_URL_SEARCH_BUSINESS_USING_LOCATION(location: String) -> String {
        return "https://api.yelp.com/v3/businesses/search?sort_by=best_match&categories=\(Constants.CATEGORIES)&limit=\(Constants.QUERY_LIMIT)&location=\(location)"
    }
    
    static func API_URL_SEARCH_BUSINESS_USING_COORDINATES(latitude: Double, longitude: Double) -> String {
        return "https://api.yelp.com/v3/businesses/search?sort_by=best_match&categories=\(Constants.CATEGORIES)&limit=\(Constants.QUERY_LIMIT)&latitude=\(latitude)&longitude=\(longitude)"
    }
    
    static func API_URL_GET_BUSINESS_BY_ID(_ businessId: String) -> String {
        return "https://api.yelp.com/v3/businesses/\(businessId)"
    }

    static func API_URL_GET_REVIEWS_BY_BUSINESS_ID(_ businessId: String) -> String {
        return "https://api.yelp.com/v3/businesses/\(businessId)/reviews"
    }
    
}