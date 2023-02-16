//
//  LaunchScreenView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/28/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack{
                VStack{
                    Image("foozy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
