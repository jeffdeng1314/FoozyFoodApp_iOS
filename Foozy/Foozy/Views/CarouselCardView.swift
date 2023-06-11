//
//  CarouselCardView.swift
//  Foozy
//
//  Created by Jeff Deng on 2/20/23.
//

import SwiftUI

// Horizontal scrollview for images in the Detail Page
struct CarouselCardView: View {
    @State var businessDetail:BusinessDetail
    var body: some View {
        VStack {
            TabView {
                ForEach(businessDetail.photos, id: \.self) { image in
                    ZStack {
                        RetrieveImage(imageUrl: image)
                            .padding(6)
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .frame(height: 300)
//        .cornerRadius(20)
        .shadow(radius: 300)
        
    }

}

struct RetrieveImage: View {
    let imageUrl: String
    var body: some View {
        ZStack {
            // Only iOS 15+. Reference: https://stackoverflow.com/questions/60677622/how-to-display-image-from-a-url-in-swiftui
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
        }
    }
}

struct CarouselCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCardView(businessDetail: MockObjects.fakeBusinessDetail)
    }
}
