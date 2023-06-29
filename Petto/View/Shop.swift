//
//  Shop.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 30/06/23.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var shopViewController: ShopViewController
    @EnvironmentObject var statController: StatController
    @AppStorage("coin") var coin: Int?
    
    var body: some View {
        VStack {
            Coin(coin: statController.statModel.coin!, totalCoin: 1000).offset(y: 20)
            Spacer()
            Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
            
            ForEach(shopViewController.getAll(), id: \.id) { shopItem in
                HStack(spacing: 40) {
                    Text("\(shopItem.name)")
                        .font(.subheadline)
                    
                    HStack {
                        StrokeText(text: "\(shopItem.price)", width: 1, color: Color("CoinBorder"))
                            .font(.subheadline)
                            .foregroundColor(Color("Coin")).fontWeight(.bold)

                        Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                    }
                    
                    Button {
                        shopViewController.buy(shopItem: shopItem)
                        print("Buy \(shopItem.name)")
                    } label: {
                        Text("Buy")
                            .font(.caption)
                    }
                    .buttonStyle(IconButtonRect(width: 70, height: 20))
                }
            }
            Spacer()
        }
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var shopViewController = ShopViewController()
        @StateObject var statController = StatController()
        
        Shop()
            .environmentObject(shopViewController)
            .environmentObject(statController)
    }
}
