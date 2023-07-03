//
//  ShopItem.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 03/07/23.
//

import SwiftUI

struct ShopItemComponent: View {
    @Binding var price: Int
    @Binding var amount: Int
    
    var body: some View {
        ZStack {
            VStack {
                Image("Vacuum").resizable().frame(width: 60, height: 60)
            }.padding()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack(spacing: 3) {
                        StrokeText(text: "\(50)", width: 1, color: Color("CoinBorder"))
                            .foregroundColor(Color("Coin")).fontWeight(.bold)
                            .font(.system(size: 16, weight: .bold))
                        Image("StarCoin").resizable().frame(width: 15, height: 15)
                    }
                }
            }.padding(5)
        }.frame(width: 110, height: 110)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct ShopItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        ShopItemComponent(price: .constant(50), amount: .constant(3))
    }
}
