//
//  ContentView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State var isPrensentingDetailModal = false
    @State var cardForDetail: Card = Card(businessId: "123", name: "sakura noodle house", image: "sakura-noodle-house", rating: 4.5, reviewCounts: 8, categories: ["food","trunk"])
    
    var body: some View {
        VStack{
            // Top Stack
            HStack{

                Image("foozy-word")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 70)

                Spacer()
                
                Spacer()
                
                Button(action: {}) {
                    Image("user")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                }
                .padding()
            }
            
            // Card
            ZStack{
                if homeViewModel.isLoading {
                    let _ = print("Loading Home Page")
                    ProgressView("Loading")
                }
                else {
                    if let businesses = homeViewModel.displayBusinesses {
                        
                        if businesses.isEmpty {
                            ErrorView()
                        }
                        else {
                            ForEach(businesses) { business in
                                CardView(card: business, cardForDetail: $cardForDetail, isPrensentingDetailModal: $isPrensentingDetailModal)
                                   .environmentObject(homeViewModel)
                                   .padding(8)
                                   .onTapGesture {
                                       self.isPrensentingDetailModal.toggle()
                                   }
                           }
                        }
                    }
                    else {
                        ProgressView()
                    }
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear{
                homeViewModel.fetchYelpBusinesses(cityName: "Portland")
            }
            
            
            // Bottom Stack
            HStack(spacing: 30){
                Button(action: {
                    doSwipe()
                }) {
                    Image("nope")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                
                Button(action: {
                    self.isPrensentingDetailModal.toggle()
                }) {
                    Image("info")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                
                Button(action: {
                    doSwipe(rightSwipe: true)
                }) {
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
        .sheet(isPresented: $isPrensentingDetailModal) {
            DetailModal(isPresentingDetailModal: $isPrensentingDetailModal, cardForDetail: cardForDetail)
            
        }
    }
    
    // removing cards when click to swipe
    func doSwipe(rightSwipe: Bool = false) {
        // swipe
        guard let last = homeViewModel.displayBusinesses.last else {
            return
        }
        
        // Use notification to post and receive in the CardView
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": last.businessId,
            "rightSwipe": rightSwipe
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HomeViewModel())
    }
}
