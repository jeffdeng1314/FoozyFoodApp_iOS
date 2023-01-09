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
    
    init() {
        // fetch the businesses
        fetchedBusinesses = [
            Card(businessId: "123", name: "Sakura Noodle House", image: "sakura-noodle-house", rating: 4.5, categories: ["Ramen, Noodle, Food Trucks"]),
            Card(businessId: "456", name: "Bobablastic", image: "bobablastic", rating: 2.5, categories: ["Bubble Tea, Coffee & Tea, Food Trucks"])
        ]
    }
}
