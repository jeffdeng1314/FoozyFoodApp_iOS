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
            Image("sakura-noodle-house")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Bottom Stack
            HStack{
                
            }
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
