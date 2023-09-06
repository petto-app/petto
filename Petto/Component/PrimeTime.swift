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
        let radius = rect.height / 2
        let center = CGPoint(x: rect.midX, y: rect.midY * 1.5)
        var path = Path()
        path.addArc(center: center, radius: radius,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct PrimeTime: View {
    @State private var timeRemaining: Int = 0
    @EnvironmentObject var timeController: TimeController
    @EnvironmentObject var timerController: TimerController

    var timerKey = "primeTimeTimer"

    var body: some View {
        VStack {
            ZStack {
                CircleShape().foregroundColor(Color("PrimetimeContainer"))
                    .frame(width: 100, height: 100)
                    .offset(y: -5)
                    .shadow(radius: 2, y: 3)
                VStack {
                    Text("Prime Time").font(.system(size: 11)).fontWeight(.bold)
                    Text("\(String(format: "%02d", timeRemaining / 60)):\(String(format: "%02d", timeRemaining % 60))").font(.headline).fontWeight(.bold)
                }.foregroundColor(.black)
            }
        }.onAppear {
            timeRemaining = timeController.getPrimeTimeSecondsRemaining()

            timerController.setTimer(key: timerKey, withInterval: 1) {
                timeRemaining = timeController.getPrimeTimeSecondsRemaining()
            }
        }
    }
}

struct PrimeTime_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var timerController = TimerController()
        @StateObject var timeController = TimeController()
        PrimeTime(timerKey: "primeTimeTimer").environmentObject(timerController)
            .environmentObject(timeController)
    }
}
