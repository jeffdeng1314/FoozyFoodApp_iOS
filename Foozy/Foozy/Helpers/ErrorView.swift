//
//  ErrorView.swift
//  Foozy
//
//  Created by Jeff Deng on 1/8/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Text("You have explored all the restaurants nearby!")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .cornerRadius(10)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
