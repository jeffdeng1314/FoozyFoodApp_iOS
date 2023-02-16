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
    
    static let API_URL_SEARCH_BUSINESS = "https://api.yelp.com/v3/businesses/search?sort_by=best_match&categories=\(Constants.CATEGORIES)&limit=\(Constants.QUERY_LIMIT)"
    
    static let API_URL_GET_BUSINESS_BY_ID = "https://api.yelp.com/v3/businesses/"
    
    
}
