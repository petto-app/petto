//
//  PrimeTime.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI

struct PrimeTime: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .frame(width: 200, height: 200).foregroundColor(Color("PrimetimeContainer"))
                VStack {
                    Text("Prime Time")
                    Text("10:20")
                }
            }
        }
    }
}

struct PrimeTime_Previews: PreviewProvider {
    static var previews: some View {
        PrimeTime()
    }
}
