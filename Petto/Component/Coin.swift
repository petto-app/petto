//
//  TotalCoin.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI
import SwiftUITooltip

struct Coin: View {
    @EnvironmentObject var audioController: AudioController
    var tooltipConfig = DefaultTooltipConfig()
    let totalCoin: Int
    let coin: Int
    @State private var showTooltip = false

    init(coin: Int, totalCoin: Int) {
        tooltipConfig.enableAnimation = true
        tooltipConfig.animationOffset = 10
        tooltipConfig.animationTime = 1
        tooltipConfig.side = .top
        tooltipConfig.backgroundColor = .white
        tooltipConfig.borderColor = .black
        self.totalCoin = totalCoin
        self.coin = coin
    }

    var body: some View {
        VStack {
            HStack {
                Text("Star Coin:").foregroundColor(Color("StarCoin")).fontWeight(.bold)
                    .font(.system(size: 14, weight: .bold))
                HStack {
                    StrokeText(text: "\(coin)", width: 1, color: Color("CoinBorder"))
                        .foregroundColor(Color("Coin")).fontWeight(.bold)
                        .font(.system(size: 14, weight: .bold))
                    Image("StarCoin").resizable().frame(width: 22, height: 22)
                }
            }
            .onTapGesture {
                showTooltip = !showTooltip
                audioController.audioPlayer.playSound(soundFileName: "pop")
            }
        }
        .padding(5)
        .padding(.horizontal, 5)
        .frame(height: 30)
        .background(.white)
        .cornerRadius(25)
        .shadow(radius: 2, y: 3)
        .tooltip(showTooltip, config: tooltipConfig) {
            Text("Total Coin: \(totalCoin)").font(.caption).foregroundColor(.black)
        }
    }
}

struct Coin_Previews: PreviewProvider {
    static var previews: some View {
        Coin(coin: 100, totalCoin: 1000)
    }
}
