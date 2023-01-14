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
        ScrollView {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 10)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            
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
//                    VStack{
//                        Text("Hello, World!")
//                    }
//                    .frame(height: 30)
//                    .frame(maxWidth: .infinity)
//                    .background(.white)
                }
                
            }
        }
//        .background {
//            ZStack {
//                RoundedRectangle(cornerRadius: 30)
//                Rectangle().frame(height: 400 / 2)
//             }
//            .foregroundColor(Color.gray)
//        }

    }
}

struct DetailModal_Previews: PreviewProvider {
    static var previews: some View {
        DetailModal(isPresentingDetailModal: .constant(true))
    }
}
