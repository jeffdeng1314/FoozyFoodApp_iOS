//
//  DetailModal.swift
//  Foozy
//
//  Created by Jeff Deng on 1/13/23.
//

import SwiftUI

struct DetailModal: View {
    @Binding var isPresentingDetailModal: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack() {
                // NavigationView
                VStack{
                    Capsule()
                        .fill(Color.secondary)
                        .opacity(0.6)
                        .frame(width: 60, height: 7)
                        .padding(20)
                }
                
            }
            
            Divider()
            
            ScrollView() {
                ZStack(alignment: .bottom) {
                    if isPresentingDetailModal {
                        Color.black
                            .opacity(0.3)
                            .onTapGesture {
                                isPresentingDetailModal = false
                            }
                        
                        VStack {
                            ForEach (0..<10) { index in
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 200)
                            }
                        }
                    }
                    
                }
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.gray.edgesIgnoringSafeArea(.all))
        .background{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(UIColor.systemBackground))
        }
        

    }
}

struct DetailModal_Previews: PreviewProvider {
    static var previews: some View {
        DetailModal(isPresentingDetailModal: .constant(true))
    }
}
