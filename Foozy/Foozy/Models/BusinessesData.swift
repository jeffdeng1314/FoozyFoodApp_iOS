//
//  Business.swift
//  Foozy
//
//  Created by Jeff Deng on 1/11/23.
//

import Foundation

struct BusinessesData: Decodable {
    let businesses: [Businesses]
}

struct Businesses: Decodable {
    let id: String
    let name: String
    let image_url: String
    let rating: Double
    let review_count: Int
    let categories: [Categories]
}

struct Categories: Decodable {
    let title: String
}
