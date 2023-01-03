//
//  ContentView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//

import SwiftUI

struct ContentView: View {
    

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
            CardView()
                .padding(8)
            
            // Bottom Stack
            HStack(spacing: 30){
                Button(action: {}) {
                    Image("previous-button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                Button(action: {}) {
                    Image("star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                }
                Button(action: {}) {
                    Image("next-button")
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
    }
}

struct CardView: View {
    // MARK: - Drawing Constants
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    var body: some View {
        ZStack(alignment: .leading) {
            Image("sakura-noodle-house")
                .resizable()
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            
            VStack{
                Spacer()
                VStack(alignment: .leading){
                    
                    // star rating
                    StarsView(rating: 4.5, maxRating: 5)
                        .frame(width: 100)
                        .padding(.bottom, -10)
                    
                    // business name
                    Text("Sakura Noodle House")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                    
                    // categories
                    Text("Ramen, Noodle, Food Truck")
                }
            }
            .padding()
            .foregroundColor(.white)
            
        }
        .cornerRadius(10)
    }
}
