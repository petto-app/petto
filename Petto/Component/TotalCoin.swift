//
//  TotalCoin.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI

struct TotalCoin: View {
    var body: some View {
        VStack {
            HStack {
                Text("Star Coin:").foregroundColor(Color("StarCoin")).fontWeight(.bold)
                HStack {
                    StrokeText(text: "150", width: 1, color: Color("CoinBorder"))
                        .foregroundColor(Color("Coin")).fontWeight(.bold)
                    Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                }
            }
        }
        .padding(5)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

struct TotalCoin_Previews: PreviewProvider {
    static var previews: some View {
        TotalCoin()
    }
}
