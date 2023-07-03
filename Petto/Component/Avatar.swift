//
//  Avatar.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 23/06/23.
//

import SwiftUI

struct Avatar: View {
    @Binding var idleFrameNames: [String]
    var scale = 1.0

    var body: some View {
        TimelineView(.animation) { timeline in
            if idleFrameNames.count > 0 {
                Canvas { context, size in
                    let now = Int(secondsValue(for: timeline.date))
                    let frameIndex = now % idleFrameNames.count

//                    let image = UIImage(named: idleFrameNames[frameIndex])!
//                    let imageWidth = image.size.width
//                    let imageHeight = image.size.height
//                    let imageWidthScaled = imageWidth * scale
//                    let imageHeightScaled = imageHeight * scale
                    let w = size.width
                    let h = size.height

//                    let translateX = abs(imageWidth / 2 - imageWidthScaled / 2)
//                    let translateY = abs(imageHeight / 2 - imageHeightScaled / 2)
//
//                    context.scaleBy(x: scale, y: scale)
//                    context.translateBy(x: translateX, y: translateY)

//                    let renderer = ImageRenderer(content: Image(idleFrameNames[frameIndex]).resizable().scaledToFit().frame(width: 300 * scale, height: 300 * scale))
                    // Draw Images
                    context.draw(
                        Image(idleFrameNames[frameIndex]).resizable(),
                        at: CGPoint(x: w / 2, y: h / 2)
                    )
                }
            }
        }
    }

    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds)
    }

    private func nanosValue(for date: Date) -> Double {
        let nanos = Calendar.current.component(.nanosecond, from: date)
        return Double(nanos)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(idleFrameNames: .constant(["shiba-idle"]))
    }
}
