//
//  PulseButton.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 03/07/23.
//

import SwiftUI

// MARK: - Strucutre for Circle

struct CircleData: Hashable {
    let width: CGFloat
    let opacity: Double
}

struct PulseButton<Content: View>: View {
    // MARK: - Properties

    @State private var isAnimating: Bool = false
    var color: Color
    var systemImageName: String
    var buttonWidth: CGFloat
    var numberOfOuterCircles: Int
    var animationDuration: Double
    var circleArray = [CircleData]()

    var children: () -> Content

    init(color: Color = Color.blue, systemImageName: String = "plus.circle.fill", buttonWidth: CGFloat = 48, numberOfOuterCircles: Int = 2, animationDuration: Double = 0.5, children: @escaping () -> Content = { Image(systemName: "plus")
            .resizable()
            .scaledToFit()
            .background(Circle().fill(Color.white))
            .frame(width: 48, height: 48, alignment: .center)
            .accentColor(.red)
    }) {
        self.color = color
        self.systemImageName = systemImageName
        self.buttonWidth = buttonWidth
        self.numberOfOuterCircles = numberOfOuterCircles
        self.animationDuration = animationDuration

        var circleWidth = self.buttonWidth
        var opacity = (numberOfOuterCircles > 4) ? 0.40 : 0.20
        self.children = children

        for _ in 0 ..< numberOfOuterCircles {
            circleWidth += 20
            circleArray.append(CircleData(width: circleWidth, opacity: opacity))
            opacity -= 0.05
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Group {
                ForEach(circleArray, id: \.self) { circle in
                    Circle()
                        .fill(self.color)
                        .opacity(self.isAnimating ? circle.opacity : 0)
                        .frame(width: circle.width, height: circle.width, alignment: .center)
                        .scaleEffect(self.isAnimating ? 1 : 0)
                }
            }
            .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true),
                       value: self.isAnimating)

            self.children()
        } //: ZSTACK
        .onAppear {
            self.isAnimating.toggle()
        }
    }
}

// MARK: - Preview

struct PulseButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Banger")
            VStack {
                Text("Banger")
                PulseButton(color: .red) {
                    Button {
                        print("Button pressed!")
                    } label: { PulseButton(color: .red) {
                        Image("exclamation").resizable(
                        )
                        .scaledToFit().frame(width: 40, height: 40)
                    }
                    }.buttonStyle(IconButtonRect(width: 50, height: 50))
                }
            }
        }
    }
}
