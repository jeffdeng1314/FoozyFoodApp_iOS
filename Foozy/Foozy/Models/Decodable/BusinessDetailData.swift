//
//  BusinessDetailData.swift
//  Foozy
//
//  Created by Jeff Deng on 1/25/23.
//

import Foundation

struct BusinessDetailData: Decodable {
    let id: String
    let is_closed: Bool
    let url: String
    let phone: String
    let display_phone: String
    let photos: [String]
    let location: Location
    let coordinates: Coordinates
    let price: String
    let hours: [Hours]
    
}

struct Hours: Decodable {
    let open: [Open]
    let is_open_now: Bool
}

struct Open: Decodable {
    let is_overnight: Bool
    let start: String
    let end: String
    let day: Int
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Location: Decodable {
    let address1: String
    let city: String
    let zip_code: String
    let country: String
    let state: String
    let display_address: [String]
}
