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
                if homeViewModel.isLoading {
                    let _ = print("loading?????????")
                    ProgressView("Loading")
                }
                else {
                    if let businesses = homeViewModel.displayBusinesses {
                        
                        if businesses.isEmpty {
                            ErrorView()
                        }
                        else {
                            ForEach(businesses) { business in
                               CardView(card: business)
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
            DetailModal(isPresentingDetailModal: $isPrensentingDetailModal)
            
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
