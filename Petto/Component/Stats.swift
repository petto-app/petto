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

    var funProjection: Int = 0
    var hygieneProjection: Int = 0
    var energyProjection: Int = 0

    var body: some View {
        VStack {
            Grid(horizontalSpacing: 8) {
                GridRow {
                    HStack {
                        Image("BurgerIcon").resizable().scaledToFill().frame(width: 30, height: 30)
                        Text("Energy").font(.custom(
                            "MotleyForces",
                            size: 12,
                            relativeTo: .body))
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        Image("ControllerIcon").resizable().scaledToFill().frame(width: 27, height: 27)
                        Text("Fun").font(.custom(
                            "MotleyForcesRegular",
                            size: 12,
                            relativeTo: .body))
                        Spacer()
                    }.padding(.leading, 10)
                    HStack(spacing: 10) {
                        Image("VacuumIcon").resizable().scaledToFill().frame(width: 29, height: 29)
                        Text("Hygiene").font(.custom(
                            "MotleyForcesRegular",
                            size: 12,
                            relativeTo: .body))
                        Spacer()
                    }.padding(.leading, 5)
                }
                GridRow {
                    StatBar(value: $energy, projectedValue: energyProjection)
                    StatBar(value: $fun, projectedValue: funProjection)
                    StatBar(value: $hygiene, projectedValue: hygieneProjection)
                }
            }
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2, y: 3)
        .foregroundColor(.black)
        .onAppear {
            for family in UIFont.familyNames {
                print(family)
                for names in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
        }
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats(fun: .constant(50), hygiene: .constant(50), energy: .constant(50))
    }
}
