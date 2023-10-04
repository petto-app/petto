//
//  Checkbox.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 06/07/23.
//

import Foundation
import SwiftUI

struct IOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {
            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")

                configuration.label
            }
        })
    }
}
