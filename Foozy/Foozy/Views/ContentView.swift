//
//  ContentView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack{
            // Top Stack
            HStack{
                Button(action: {}) {
                    Image("user")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image("setting")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
            }.padding(.horizontal)
            
            // Card
            ZStack{
                if let businesses = homeViewModel.displayBusinesses {
                    if businesses.isEmpty {
                        let _ = homeViewModel.assignFetchedToDisplayBusinesses()
//                        Text("Please come back later")
//                            .font(.caption)
//                            .foregroundColor(.gray)
                    }
                    else {
                        ForEach(businesses) { business in
                            CardView(card: business, homeViewModel: homeViewModel)
                                .padding(8)
                        }
                    }
                }
            }
            
            // Bottom Stack
            HStack(spacing: 30){
                Button(action: {}) {
                    Image("nope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                Button(action: {}) {
                    Image("info")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                Button(action: {}) {
                    Image("green-heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HomeViewModel())
    }
}

