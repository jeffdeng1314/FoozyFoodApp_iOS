//
//  StarRating.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import Foundation
import SwiftUI

// reference: https://stackoverflow.com/questions/64379079/how-to-present-accurate-star-rating-using-swiftui
struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int
    var reviewCounts: Int

    var body: some View {
        HStack{
            let stars = HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            stars.overlay(
                GeometryReader { g in
                    let width = rating / CGFloat(maxRating) * (g.size.width * 1.2)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(.red)
                    }
                }
                .mask(stars)
            )
            .foregroundColor(.gray)
            
            Text(String(reviewCounts))
                .font(.caption)
                .fontWeight(.bold)
                .aspectRatio(contentMode: .fit)
        }
    }
}
