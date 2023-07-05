//
//  ShopItem.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 03/07/23.
//

import SwiftUI

struct ShopItemComponent: View {
    var price: Int
    @State var image: String?
    @Binding var amount: Int

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Image(image ?? "Banana").resizable().frame(width: 60, height: 60)
                }.padding()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack(spacing: 3) {
                            StrokeText(text: "\(price)", width: 1, color: Color("CoinBorder"))
                                .foregroundColor(Color("Coin")).fontWeight(.bold)
                                .font(.system(size: 16, weight: .bold))
                            Image("StarCoin").resizable().frame(width: 15, height: 15)
                        }
                    }
                }.padding(5)
            }.frame(width: 110, height: 110)
                .background(.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            HStack(spacing: 10) {
                AmountButton(type: .Minus, enabled: amount > 0) {
                    if amount > 0 {
                        amount -= 1
                    }
                }
                StrokeText(text: "\(amount)", width: 1, color: Color("CoinBorder"))
                    .foregroundColor(Color("Coin")).fontWeight(.bold)
                    .font(.system(size: 14, weight: .bold))
                AmountButton(type: .Plus, enabled: true) {
                    amount += 1
                }
            }
        }
    }
}

struct ShopItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        @State var amount = 69
        ShopItemComponent(price: 50, amount: $amount)
    }
}
