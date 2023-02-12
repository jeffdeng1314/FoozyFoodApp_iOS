//
//  Detail.swift
//  Foozy
//
//  Created by Jeff Deng on 1/24/23.
//

import Foundation
import SwiftUI

struct BusinessDetail {
    let name: String
    let phone: Phone?
    let reviews: Reviews
    let photos: [String]
    let price: String
    let hours: [Hour]
    let categories: [String]
    let coordinates: [Coordinate]
    let address: [String]
    let url: String
    let isClosed: Bool
}


struct Coordinate {
    let latitude: String
    let longitude: String
}

struct Reviews {
    let rating: CGFloat
    let reviewCounts: Int
    let review: [Review]
}

struct Review {
    let text: String
    let rating: CGFloat
    let user: String
    let url: String
}

struct Phone {
    let number: String?
    let displayPhone: String?
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
