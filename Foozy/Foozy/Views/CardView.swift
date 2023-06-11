//
//  CardView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//
import SwiftUI

struct CardView: View, Identifiable {
    let id = UUID()
    @State var card: Card
    @State var cardForDetail: Card? = nil
    @Binding var isPresentingDetailModal: Bool
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var xPosition: CGFloat = 0.0
    @State private var yPosition: CGFloat = 0.0
    @State private var degree: Double = 0.0
        
    var body: some View {
        ZStack(alignment: .leading) {
            
            InformationView(card: card)
                .onTapGesture {
                    self.isPresentingDetailModal.toggle()
                    let _ = print("tapped")
                }
            if isPresentingDetailModal {
                let _ = DispatchQueue.main.async {
                    self.cardForDetail = self.card
                }
                

            }
            
            let _ = print("id: \(id), name: \(card.name)")
        }
        .cornerRadius(10)
        // step 1 - ZStack follows the coordinate of the card
        .offset(x: xPosition, y: yPosition)
        .rotationEffect(.init(degrees: degree))
        // step 2 - gesture recognizer updates the coordinate values of the card model
        .gesture(
            DragGesture()
                .onChanged({ value in
                    // user dragging the view
                    withAnimation(.default) {
                        xPosition = value.translation.width
                        yPosition = value.translation.height
                        degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                })
                .onEnded({ value in
                    // do something when the user stops dragging
                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 8, initialVelocity: 5)) {
                        switch value.translation.width {
                        case 0...100, (-100)...(-1):
                            xPosition = 0; yPosition = 0; degree = 0
//                        case (-100)...(-1):
//                            card.x = 0; card.y = 0; card.degree = 0
                        case let x where x > 100:
                            xPosition = 500; degree = 12
                        case let x where x < 100:
                            xPosition = -500; degree = -12
                        default:
                            xPosition = 0; yPosition = 0; degree = 0
                        }
                        
                        swipeUpdate(position: xPosition, card: card)
                    }
                })
        )
        // Receiving Notifications Posted from the ContentView (the bottom buttons)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) {
            data in
            
            guard let info = data.userInfo else{
                return
            }
            
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = CGFloat(500)
            let pos = Double(12)
            let height = CGFloat(0)
            
            if card.businessId == id {
                withAnimation(.default) {
                    if rightSwipe {
                        xPosition = width
                        yPosition = height
                        degree = pos
                    }
                    else {
                        xPosition = (-width)
                        yPosition = height
                        degree = (-pos)
                    }
                    
                }
                swipeUpdate(position: xPosition, card: card)
            }
        }
        .sheet(isPresented: $isPresentingDetailModal) {
            if cardForDetail != nil {
                DetailModalView(cardForDetail: cardForDetail!)
            } else {
                let _ = print("no cardForDetail")
                ProgressView()
            }
            
        }
    }
    
    private func swipeUpdate(position cardPosition: CGFloat, card: Card) {
        switch cardPosition {
        case 500...:
            let _ = print("Right")
        case ...(-500):
            let _ = print("Left")
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
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MockObjects.fakeCard, cardForDetail: MockObjects.fakeCard, isPresentingDetailModal: .constant(true))
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

// MARK: - Drawing Constants
struct AddCardGradient: View {
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

struct InformationView: View {
    let card: Card
    var body: some View {
        ZStack(alignment: .leading) {
            DisplayCard(card: card)
            DisplayCardInfo(card: card)
        }
    }
}
