//
//  PrimeTime.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI

struct CircleShape: Shape {
    func stroked() -> some View {
        ZStack {
            self.stroke(.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }

    func path(in rect: CGRect) -> Path {
        let r = rect.height / 2
        let center = CGPoint(x: rect.midX, y: rect.midY * 1.5)
        var path = Path()
        path.addArc(center: center, radius: r,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct PrimeTime: View {
    var body: some View {
        VStack {
            ZStack {
                CircleShape().foregroundColor(Color("PrimetimeContainer"))
                    .frame(width: 100, height: 100)
                    .offset(y: -5)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                VStack {
                    Text("Prime Time").font(.footnote)
                    Text("10:20").font(.subheadline)
                }.foregroundColor(.black)
            }
        }
    }
}

struct PrimeTime_Previews: PreviewProvider {
    static var previews: some View {
        PrimeTime()
    }
}
