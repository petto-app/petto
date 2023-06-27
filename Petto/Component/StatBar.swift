//
//  StatBar.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 22/06/23.
//

import SwiftUI
import SwiftUITooltip

struct StatBar: View {
    var tooltipConfig = DefaultTooltipConfig()
    @Binding var value: Int
    @State private var barValue = 0.0
    @State private var showTooltip = false

    init(value: Binding<Int>) {
        tooltipConfig.enableAnimation = true
        tooltipConfig.animationOffset = 10
        tooltipConfig.animationTime = 1
        tooltipConfig.side = .top
        tooltipConfig.backgroundColor = .white
        tooltipConfig.borderColor = .black

        _value = value
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.white)

                Rectangle().frame(width: min(CGFloat(self.barValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(barValue > 0.5 ? Color("BarHigh") : barValue > 0.2 ? .yellow : Color("BarLow"))
                    .animation(.linear, value: UUID())
            }.cornerRadius(45.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 45)
                        .stroke(Color.black, lineWidth: 1)
                )
                .onTapGesture {
                    showTooltip = !showTooltip
                }
        }
        .tooltip(showTooltip, config: tooltipConfig) {
            Text("\(value)/100").font(.caption)
        }.frame(height: 25)
        .onChange(of: value) { newValue in
            barValue = 0
            for _ in 0 ..< newValue {
                barValue += 0.01
            }
        }
        .onAppear {
            barValue = 0
            for _ in 0 ..< value {
                barValue += 0.01
            }
        }
    }
}

struct StatBarView: View {
    @State var progressValue: Int = 0

    var body: some View {
        VStack {
            StatBar(value: $progressValue).frame(height: 30)

            Button(action: {
                self.startProgressBar()
            }) {
                Text("Start Progress")
            }.padding()

            Button(action: {
                self.resetProgressBar()
            }) {
                Text("Reset")
            }
        }.padding()
    }

    func startProgressBar() {
        for _ in 0 ... 60 {
            progressValue += 1
        }
    }

    func resetProgressBar() {
        progressValue = 0
    }
}

struct StatBar_Previews: PreviewProvider {
    static var previews: some View {
        StatBarView()
    }
}
