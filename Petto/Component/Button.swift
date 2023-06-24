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
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(Color("ButtonPrimary"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("ButtonPrimaryBorder"), lineWidth: 3)
            )
            .fontWeight(.bold)
    }
}

struct ButtonView: View {
    var body: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButton(width: 80))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
