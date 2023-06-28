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
        let r = rect.height / 1.4
        let center = CGPoint(x: rect.midX, y: rect.midY * 1.5)
        var path = Path()
        path.addArc(center: center, radius: r,
                    startAngle: Angle(degrees: -20), endAngle: Angle(degrees: 200), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct PrimeTime: View {
    @State private var timeRemaining: Int = 0
    @StateObject var timeController: TimeController = .init()
    @EnvironmentObject var timerController: TimerController

    var body: some View {
        VStack {
            ZStack {
                CircleShape().foregroundColor(Color("PrimetimeContainer"))
                    .frame(width: 100, height: 100)
                    .offset(y: 20)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                VStack {
                    Text("Prime Time").font(.system(size: 11)).fontWeight(.bold)
                    Text("\(String(format: "%02d", timeRemaining / 3600)):\(String(format: "%02d", timeRemaining / 60 % 60)):\(String(format: "%02d", timeRemaining % 60))").font(.headline).fontWeight(.bold)
                }.foregroundColor(.black)
            }
        }.onAppear {
            timeRemaining = timeController.getSecondsRemaining()

            timerController.setTimer(key: "primeTimeTimer", withInterval: 1) {
                timeRemaining -= 1
            }
        }
    }
}

struct PrimeTime_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var timerController = TimerController()
        PrimeTime().environmentObject(timerController)
    }
}
