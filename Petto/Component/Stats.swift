//
//  Stats.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 22/06/23.
//

import SwiftUI

struct Stats: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                VStack {
                    HStack {
                        Image("BurgerIcon")
                        Text("Energy").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: .constant(50))
                }
                VStack {
                    HStack {
                        Image("ControllerIcon")
                        Text("Fun").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: .constant(50))
                }
                VStack {
                    HStack {
                        Image("VacuumIcon")
                        Text("Hygiene").font(.custom(
                            "AmericanTypewriter",
                            size: 13,
                            relativeTo: .body))
                        Spacer()
                    }
                    StatBar(value: .constant(50))
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
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
