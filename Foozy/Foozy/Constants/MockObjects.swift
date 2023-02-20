//
//  MockObjects.swift
//  Foozy
//
//  Created by Jeff Deng on 2/20/23.
//

import Foundation

struct MockObjects {
    // MARK: - Card
    static var fakeCard: Card = Card(businessId: "123", name: "sakura noodle house", image: "sakura-noodle-house", rating: 4.5, reviewCounts: 8, categories: ["food","trunk"])
    
    
    // MARK: - BusinessDetail
    static var fakeBusinessDetail: BusinessDetail = BusinessDetail(
        name: "Sakura Noodle House",
        phone: Phone(number: "123456789", displayPhone: "123456789"),
        reviews: nil, image: "url",
        photos: ["url,url,url"],
        price: "$",
        hours: [Hour(open: [Schedule(isOvernight: false, start: "11", end: "11", day: 0)], isOpenNow: false)],
        categories: ["food,food-trucks"],
        coordinate: Coordinate(latitude: 10, longitude: 10),
        address: ["somewhere, where"],
        url: "url",
        isClosed: false
    )
}
