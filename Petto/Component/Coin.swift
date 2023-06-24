//
//  TotalCoin.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SwiftUI
import SwiftUITooltip

struct Coin: View {
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
        self.totalCoin = totalCoin
        self.coin = coin
    }

    var body: some View {
        VStack {
            HStack {
                Text("Star Coin:").foregroundColor(Color("StarCoin")).fontWeight(.bold)
                HStack {
                    StrokeText(text: "\(coin)", width: 1, color: Color("CoinBorder"))
                        .foregroundColor(Color("Coin")).fontWeight(.bold)
                    Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                }
            }
            .onTapGesture {
                showTooltip = !showTooltip
            }
        }
        .padding(5)
        .frame(height: 30)
        .background(.white)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 2)
        )
        .tooltip(showTooltip, config: tooltipConfig) {
            Text("Total Coin: \(totalCoin)").font(.caption)
        }
    }
}

struct Coin_Previews: PreviewProvider {
    static var previews: some View {
        Coin(coin: 100, totalCoin: 1000)
    }
}
