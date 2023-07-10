//
//  Button.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import SwiftUI

struct MainButton: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    var buttonColor = Color("ButtonPrimary")
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(buttonColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .fontWeight(.bold)
            .shadow(radius: 2, y: 3)
    }
}

struct BrownButton: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    var active: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(active ? Color("StarCoin") : .white)
            .foregroundColor(active ? .white : Color("StarCoin"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("StarCoin"), lineWidth: 3)
            )
            .fontWeight(.bold)
    }
}

struct ButtonView: View {
    @State var active = false
    var body: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButton(width: 80))
        Button("Press Me") {
            print("Button pressed!")
            active = !active
        }
        .buttonStyle(BrownButton(width: 80, active: active))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
