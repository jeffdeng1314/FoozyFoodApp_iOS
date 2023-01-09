//
//  CardData.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var displayBusinesses: [Card] = []
    @Published var fetchedBusinesses: [Card] = []
    @ObservedObject var networkManager: NetworkManager = NetworkManager()
    
    init() {
        fetchedBusinesses = [
            Card(businessId: "123", name: "Sakura Noodle House", image: "sakura-noodle-house", rating: 4.5, categories: ["Ramen, Noodle, Food Trucks"]),
            Card(businessId: "456", name: "Bobablastic", image: "bobablastic", rating: 2.5, categories: ["Bubble Tea, Coffee & Tea, Food Trucks"])
        ]
        
        displayBusinesses = fetchedBusinesses
//        assignFetchedToDisplayBusinesses()
    }
    
    func assignFetchedToDisplayBusinesses() {
        // storing it in the displayBusinesses
        // where it updates/remove the businesses through user interaction
        displayBusinesses = networkManager.fetchedBusinesses
    }
    
    func updateBusinesses(card business: Card) {
            print("card: \(business.name)")
            let displayBusinessId = displayBusinesses.last!.businessId
            
            if business.businessId == displayBusinessId {
                print("equal! Removed!")
                displayBusinesses.removeLast()
            }
            else {
                print("not equal, not removing elements")
            }
    }
}

