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
                        .frame(height: 40)
                }
                
                Spacer()
                Text("For You")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                
                Button(action: {}) {
                    Image("setting")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                }
            }
            .padding()
            
            // Card
            ZStack{
                if let businesses = homeViewModel.displayBusinesses {
                    if businesses.isEmpty {
//                        let _ = homeViewModel.assignFetchedToDisplayBusinesses()
//                        Text("Please come back later")
//                            .font(.caption)
//                            .foregroundColor(.gray)
                        ErrorView()
                    }
                    else {
                        ForEach(businesses) { business in
                            CardView(card: business)
                                .environmentObject(homeViewModel)
                                .padding(8)
                        }
                    }
                }
                else {
                    ProgressView()
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
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
            .padding(.bottom)
            .disabled(homeViewModel.displayBusinesses.isEmpty)
            .opacity((homeViewModel.displayBusinesses.isEmpty) ? 0.6 : 1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HomeViewModel())
    }
}

