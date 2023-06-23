//
//  SettingsButton.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI

struct IconButton: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding(5)
            .background(.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

struct SettingsButtonView: View {
    var body: some View {
        Button {
            print("Button pressed!")
        } label: {
            Image(systemName: "gearshape")
        }.buttonStyle(IconButton())
    }
}

struct SettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonView()
    }
}
