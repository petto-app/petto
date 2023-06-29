//
//  Stats.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 22/06/23.
//

import SwiftUI

struct Stats: View {
    @Binding var fun: Int?
    @Binding var hygiene: Int?
    @Binding var energy: Int?

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                VStack {
                    HStack {
                        Image("BurgerIcon").resizable().scaledToFill().frame(width: 30, height: 30)
                        Text("Energy").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: $energy)
                }
                VStack {
                    HStack {
                        Image("ControllerIcon").resizable().scaledToFill().frame(width: 27, height: 27)
                        Text("Fun").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: $fun)
                }
                VStack {
                    HStack {
                        Image("VacuumIcon").resizable().scaledToFill().frame(width: 29, height: 29)
                        Text("Hygiene").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: $hygiene)
                }
            }
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .foregroundColor(.black)
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats(fun: .constant(50), hygiene: .constant(50), energy: .constant(50))
    }
}
