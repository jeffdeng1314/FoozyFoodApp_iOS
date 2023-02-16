//
//  Detail.swift
//  Foozy
//
//  Created by Jeff Deng on 1/24/23.
//

import Foundation

struct BusinessDetail {
    let name: String
    let phone: Phone
    let reviews: Reviews?
    let image: String
    let photos: [String]
    let price: String
    let hours: [Hour]
    let categories: [String]
    let coordinate: Coordinate
    let address: [String]
    let url: String
    let isClosed: Bool
}


struct Coordinate {
    let latitude: Double
    let longitude: Double
}

struct Reviews {
    let rating: CGFloat?
    let reviewCounts: Int?
    let review: [Review]
}

struct Review {
    let text: String
    let rating: CGFloat
    let user: String
    let url: String
}

struct Phone {
    let number: String
    let displayPhone: String
}

struct Hour {
    let open: [Schedule]
    let isOpenNow: Bool
}

struct Schedule {
    let isOvernight: Bool
    let start: String
    let end: String
    let day: Int
}
