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
        for index in 0 ..< amounts.count {
            amounts[index] = 0
        }
    }

    let width = UIScreen.main.bounds.size.width * 0.15
    let height = UIScreen.main.bounds.size.height * 0.005

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
                .buttonStyle(BrownButton(width: width, height: height, active: activeType == .energy))
                Button("Fun") {
                    print("Button pressed!")
                    activeType = .fun
                    resetAmounts()
                    audioController.audioPlayer.playSound(soundFileName: "pop")
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: width, height: height, active: activeType == .fun))
                Button("Hygiene") {
                    print("Button pressed!")
                    activeType = .hygiene
                    resetAmounts()
                    audioController.audioPlayer.playSound(soundFileName: "pop")
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: width, height: height, active: activeType == .hygiene))
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
