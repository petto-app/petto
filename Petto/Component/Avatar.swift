//
//  Avatar.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 23/06/23.
//

import SwiftUI

struct Avatar: View {
    @Binding var idleFrameNames: [String]

    var body: some View {
        TimelineView(.animation) { timeline in
            if idleFrameNames.count > 0 {
                Canvas { context, size in
                    let w = size.width
                    let h = size.height

                    let now = Int(secondsValue(for: timeline.date))

                    let frameIndex = now % idleFrameNames.count

                    // Draw Images
                    context.draw(Image(idleFrameNames[frameIndex]), at: CGPoint(x: w / 2, y: h / 2.2))
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
