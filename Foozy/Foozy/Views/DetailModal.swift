//
//  DetailModal.swift
//  Foozy
//
//  Created by Jeff Deng on 1/13/23.
//

import SwiftUI

struct DetailModal: View {
    @Binding var isPresentingDetailModal: Bool
    @State var businessId: String
    
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
            
//            Divider()
            ExDivider()

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
                                Text("我靠💩")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 300, height: 200)
                                    .background(Rectangle().fill(Color.orange).shadow(radius: 3))
                            }
                        }
                        let _ = print("businessIdForDetail: \(businessId)")
                    }
                    
                }
            }
        }

        .background{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(UIColor.systemBackground))
        }
        .edgesIgnoringSafeArea(.bottom)
        

    }
}

struct ExDivider: View {
    let color: Color = .gray
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct DetailModal_Previews: PreviewProvider {
    static var previews: some View {
        DetailModal(isPresentingDetailModal: .constant(true), businessId: "13")
    }
}
