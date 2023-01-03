//
//  CardView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/2/23.
//
import SwiftUI

struct CardView: View {
    
    @State var card: Card
    
    // MARK: - Drawing Constants
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    var body: some View {
        ZStack(alignment: .leading) {
            Image(card.image)
                .resizable()
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            
            VStack{
                Spacer()
                VStack(alignment: .leading){
                    
                    // star rating
                    StarsView(rating: card.rating, maxRating: 5)
                        .frame(width: 100)
                        .padding(.bottom, -10)
                    
                    // business name
                    Text(card.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                    
                    // categories
                    Text(card.categories.joined(separator: ","))
                }
            }
            .padding()
            .foregroundColor(.white)
            
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
                    }
                })
        )
    }
}



struct CardView_Previews: PreviewProvider {
    static var card: Card = Card(name: "sakura noodle house", image: "sakura-noodle-house", rating: 4.5, categories: ["food","trunk"])
    static var previews: some View {
        CardView(card: card)
            .previewLayout(.sizeThatFits)
    }
}
