//
//  DetailModal.swift
//  Foozy
//
//  Created by Jeff Deng on 1/13/23.
//

import SwiftUI

struct DetailModalView: View {
//    @Binding var isPresentingDetailModal: Bool
    @State var cardForDetail: Card
    @StateObject var detailViewModel = DetailViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack() {
                // NavigationView
                VStack{
                    Capsule()
                        .fill(Color.secondary)
                        .opacity(0.2)
                        .frame(width: 50, height: 5)
                        .padding(10)
                }
            }

            Spacer()
            ScrollView() {
                ZStack(alignment: .bottom) {
//                    if isPresentingDetailModal {
                        if detailViewModel.isLoading {
                            let _ = print("Loading Detail Page")
                            ProgressView("Loading")
                                .frame(width: 400, height: 700)
                            
                        }
                        else {
                            VStack {
                                CarouselCardView(businessDetail: detailViewModel.detail!)
                                HStack{
                                    Text(detailViewModel.detail!.name)
                                    Text(detailViewModel.detail!.price)

                                }
                                .padding(8)
                                
                                Text(detailViewModel.detail!.categories.joined(separator: ","))
                                Text(detailViewModel.detail!.phone.displayPhone)
                            }
                            
                            let _ = print("detail: \(detailViewModel.detail!)")
                        }
                        
//                    }
                    
                }
            }
            .onAppear {
                detailViewModel.fetchYelpBusinessDetail(card: cardForDetail)
            }
        }

        .background{
            RoundedRectangle(cornerRadius: 25)
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
        DetailModalView(cardForDetail: MockObjects.fakeCard)
    }
}
