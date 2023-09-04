//
//  Confirmation.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 06/07/23.
//

import SwiftUI

struct Confirmation: View {
    @State var message: String

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ZStack {
                    Rectangle().frame(width: 285, height: 183)
                        .foregroundColor(Color("PrimetimeContainer"))
                        .cornerRadius(10)

                    VStack {
                        Text(message)
                            .foregroundColor(Color("StarCoin"))
                            .fontWeight(.bold)
                            .padding(.bottom, 45)

                        HStack(spacing: 15) {
                            Button("Cancel") {
                                //
                            }
                            .buttonStyle(MainButton(width: 80))
                            .font(.footnote)

                            Button("Yes") {
                                //
                            }
                            .buttonStyle(MainButton(width: 80))
                            .font(.footnote)
                        }
                    }
                }
            }
        }
    }
}

struct Confirmation_Previews: PreviewProvider {
    static var previews: some View {
        Confirmation(message: "Great! 4 to go!")
    }
}
