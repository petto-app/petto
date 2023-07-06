//
//  PopUp.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 04/07/23.
//

import SwiftUI

struct PopUp: View {
    @Binding var coin: Int?

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ZStack {
                    Rectangle().frame(width: 300, height: 200)
                        .opacity(0.3)
                        .foregroundColor(Color("PrimetimeContainer"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("BlueBorder"), lineWidth: 3)
                        )

                    VStack {
                        Text("Congratulations!")
                            .foregroundColor(Color("Coin"))
                            .fontWeight(.bold)
                        Text("You got \(coin!) Coins")
                            .foregroundColor(Color("Coin"))
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        Button("Ok") {
                            print("Ok")
                        }
                        .buttonStyle(MainButton(width: 80))
                    }
                }
            }
        }
    }
}

struct PopUp_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(coin: .constant(5))
    }
}
