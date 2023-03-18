//
//  MockObjects.swift
//  Foozy
//
//  Created by Jeff Deng on 2/20/23.
//

import Foundation

struct MockObjects {
    // MARK: - Card
    static var fakeCard: Card = Card(businessId: "123", name: "sakura noodle house", image: "https://www.yelp.com/biz_photos/sakura-noodle-house-happy-valley?select=_Bt_wL3-hNCcDEQaaotAZA", rating: 4.5, reviewCounts: 8, categories: ["food","trunk"])
    
    
    // MARK: - BusinessDetail
    static var fakeBusinessDetail: BusinessDetail = BusinessDetail(
        name: "Sakura Noodle House",
        phone: Phone(number: "123456789", displayPhone: "123456789"),
        reviews: nil, image: "url",
        photos: ["https://s3-media4.fl.yelpcdn.com/bphoto/YflekuUVx-_WfNiKHHlC0A/o.jpg"],
        price: "$",
        hours: [Hour(open: [Schedule(isOvernight: false, start: "11", end: "11", day: 0)], isOpenNow: false)],
        categories: ["food,food-trucks"],
        coordinate: Coordinate(latitude: 10, longitude: 10),
        address: ["somewhere, where"],
        url: "url",
        isClosed: false
    )
}
