//
//  AmountButton.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 03/07/23.
//

import SwiftUI

enum AmountButtonType {
    case plus
    case minus
}

struct AmountButton: View {
    var type: AmountButtonType
    var enabled: Bool

    var onPress: () -> Void

    var body: some View {
        Button {
            onPress()
        } label: {
            StrokeText(text: type == .plus ? "+" : "-", width: 1, color: Color("CoinBorder"))
                .foregroundColor(enabled ? .white : Color("StarCoin")).fontWeight(.bold)
                .font(.system(size: 14, weight: .bold))
        }.frame(width: 25, height: 25)
            .background(enabled ? Color("StarCoin") : .white)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .shadow(radius: 2, y: 3)
    }
}

struct AmountButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            AmountButton(type: .plus, enabled: true) { print("Yo") }
            StrokeText(text: "\(5)", width: 1, color: Color("CoinBorder"))
                .foregroundColor(Color("Coin")).fontWeight(.bold)
                .font(.system(size: 14, weight: .bold))

            AmountButton(type: .minus, enabled: false) { print("Yo") }
        }
    }
}
