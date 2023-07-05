//
//  StrokeText.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    var textColor: Color = .black

    var body: some View {
        ZStack {
            ZStack {
                Text(text).offset(x: width, y: width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y: width)
                Text(text).offset(x: width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

struct StrokeText_Previews: PreviewProvider {
    static var previews: some View {
        StrokeText(text: "Sample Text", width: 0.5, color: .red)
            .foregroundColor(.black)
            .font(.system(size: 12, weight: .bold))
    }
}
