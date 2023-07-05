//
//  AmountButton.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 03/07/23.
//

import SwiftUI

enum AmountButtonType {
    case Plus
    case Minus
}

struct AmountButton: View {
    var type: AmountButtonType
    var enabled: Bool

    var onPress: () -> Void

    var body: some View {
        Button {
            onPress()
        } label: {
            StrokeText(text: type == .Plus ? "+" : "-", width: 1, color: Color("CoinBorder"))
                .foregroundColor(enabled ? .white : Color("StarCoin")).fontWeight(.bold)
                .font(.system(size: 14, weight: .bold))
        }.frame(width: 25, height: 25)
            .background(enabled ? Color("StarCoin") : .white)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .shadow(radius: 2, y: 3)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct AmountButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            AmountButton(type: .Plus, enabled: true) { print("Yo") }
            StrokeText(text: "\(5)", width: 1, color: Color("CoinBorder"))
                .foregroundColor(Color("Coin")).fontWeight(.bold)
                .font(.system(size: 14, weight: .bold))

            AmountButton(type: .Minus, enabled: false) { print("Yo") }
        }
    }
}
