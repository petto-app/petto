//
//  Home.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SpriteKit
import SwiftUI

struct Home: View {
    @State private var idleFrameNames: [String] = []

    var body: some View {
        VStack {
            ZStack {
                Image("wp").resizable().ignoresSafeArea(.all)
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
        }.onAppear {
            let idleFrameAtlas = SKTextureAtlas(named: "IdleFrames")
            idleFrameNames = idleFrameAtlas.textureNames.sorted()
        }
        .padding()
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
