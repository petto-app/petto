//
//  ContentView.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 18/06/23.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
    @State private var idleFrameNames: [String] = []
    
    var body: some View {
        VStack {
            ZStack {
                TimelineView(.animation) { timeline in
                    if (idleFrameNames.count > 0) {
                        Canvas { context, size in
                            let w = size.width
                            let h = size.height

                            let now = Int(secondsValue(for: timeline.date))

                            let frameIndex = now % idleFrameNames.count

                            // Draw background
                            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(.sRGB, red: 230/255, green: 240/255, blue: 1, opacity: 1.0)))


                            // Draw Images
                            context.draw(Image(idleFrameNames[frameIndex]), at: CGPoint(x: w / 2, y: h / 2.2))
                        }
                    }
                }
            }
//            Image("CMC2")
//            .edgesIgnoringSafeArea(.all)
        }.onAppear{
            let idleFrameAtlas = SKTextureAtlas(named: "IdleFrames")
            idleFrameNames = idleFrameAtlas.textureNames
            print(idleFrameAtlas.textureNames)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
