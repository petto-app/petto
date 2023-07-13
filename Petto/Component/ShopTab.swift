//
//  ShopTab.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 05/07/23.
//

import SwiftUI

struct ShopTab: View {
    @EnvironmentObject var audioController: AudioController
    @Binding var activeType: ShopItemType
    @Binding var amounts: [Int]

    func resetAmounts() {
        for i in 0 ..< amounts.count {
            amounts[i] = 0
        }
    }

    var body: some View {
        Grid {
            GridRow {
                Button("Food") {
                    print("Button pressed!")
                    activeType = .energy
                    resetAmounts()
                    audioController.audioPlayer.playSound(soundFileName: "pop")
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .energy))
                Button("Fun") {
                    print("Button pressed!")
                    activeType = .fun
                    resetAmounts()
                    audioController.audioPlayer.playSound(soundFileName: "pop")
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .fun))
                Button("Hygiene") {
                    print("Button pressed!")
                    activeType = .hygiene
                    resetAmounts()
                    audioController.audioPlayer.playSound(soundFileName: "pop")
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .hygiene))
            }
        }
    }
}

struct ShopTab_Previews: PreviewProvider {
    static var previews: some View {
        @State var type = ShopItemType.energy
        @State var amounts = [69, 69, 69]
        ShopTab(activeType: $type, amounts: $amounts)
    }
}
