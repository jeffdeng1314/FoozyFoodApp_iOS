//
//  CardView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//
import SwiftUI

struct CardView: View {
    
    @State var card: Card
    @Binding var cardForDetail: Card
    @Binding var isPrensentingDetailModal: Bool
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            DisplayCard(card: card)
            DisplayCardInfo(card: card)
            if isPrensentingDetailModal {
                let _ = assignCard()
            }
            
        }
        .cornerRadius(10)
        // step 1 - ZStack follows the coordinate of the card
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        // step 2 - gesture recognizer updates the coordinate values of the card model
        .gesture(
            DragGesture()
                .onChanged({ value in
                    // user dragging the view
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                })
                .onEnded({ value in
                    // do something when the user stops dragging
                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 8)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.y = 0; card.degree = 0
                        case (-100)...(-1):
                            card.x = 0; card.y = 0; card.degree = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case let x where x < 100:
                            card.x = -500; card.degree = -12
                        default:
                            card.x = 0; card.y = 0
                        }
                        swipeUpdate(position: card.x, card: card)
                    }
                })
        )
        // Receiving Notifications Posted...
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) {
            data in
            
            guard let info = data.userInfo else{
                return
            }
            
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = CGFloat(500)
            let degree = CGFloat(12)
            let height = CGFloat(0)
            
            if card.businessId == id {
                withAnimation(.default) {
                    if rightSwipe {
                        card.x = width
                        card.y = height
                        card.degree = degree
                    }
                    else {
                        card.x = (-width)
                        card.y = height
                        card.degree = (-degree)
                    }
                    
                }
                swipeUpdate(position: card.x, card: card)
            }
        }
    }
    
    private func swipeUpdate(position cardPosition: CGFloat, card: Card) {
        switch cardPosition {
        case 500...:
            let _ = print("Swiped right! Like")
        case ...(-500):
            let _ = print("Swiped left! Dislike")
        default:
            return
        }
        
        // The delay time is based on the animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let _ = homeViewModel.displayBusinesses.last {
                let _ = homeViewModel.updateBusinesses(card: card)
            }
        }
        
    }
    
    private func assignCard() {
        DispatchQueue.main.async {
            self.cardForDetail = self.card
        }
    }
}



struct CardView_Previews: PreviewProvider {
    static var card: Card = Card(businessId: "123", name: "sakura noodle house", image: "sakura-noodle-house", rating: 4.5, reviewCounts: 8, categories: ["food","trunk"])
    static var previews: some View {
        CardView(card: card, cardForDetail: .constant(card), isPrensentingDetailModal: .constant(true))
    }
}

struct DisplayCardInfo: View {
    let card: Card
    
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading){
                
                // star rating
                StarsView(rating: card.rating, maxRating: 5, reviewCounts: card.reviewCounts)
                    .frame(width: 120)
                    .padding(.bottom, -10)
                
                // business name
                Text(card.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                
                // categories
                Text(card.categories.joined(separator: ", "))
            }
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct AddCardGradient: View {
    // MARK: - Drawing Constants
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    
    var body: some View {
        LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
    }
}

struct DisplayCard: View {
    let card: Card
    var body: some View {
        ZStack {
            // Only iOS 15+. Reference: https://stackoverflow.com/questions/60677622/how-to-display-image-from-a-url-in-swiftui
            AsyncImage(url: URL(string: card.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
//                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }

            AddCardGradient()
        }
    }
}
