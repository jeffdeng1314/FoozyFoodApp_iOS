//
//  Card.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    
    let businessId: String
    let name: String
    let image: String
    let rating: CGFloat
    let reviewCounts: Int
    let categories: [String]
}

