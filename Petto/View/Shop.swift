//
//  Shop.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 30/06/23.
//

import SwiftUI

struct Shop: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bottomSheet: BottomSheet

    @StateObject var timeController: TimeController = .init()

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var shopViewController: ShopViewController
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var timerController: TimerController
    @AppStorage("coin") var coin: Int?
    @AppStorage("totalCoin") var totalCoin: Int?

    var body: some View {
        VStack {
            ZStack {
                Image("ShopBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    Image("ShopContainer").resizable()
                }
                VStack {
                    HStack {
                        Button {
                            dismiss()
                            timerController.stopTimer()
                        } label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Coin(coin: coin ?? 0, totalCoin: totalCoin ?? 0).offset(y: 20)
                        Spacer()
                        PrimeTime(timerKey: "primeTimeTimerShop").offset(x: -25, y: 20)
                    }
                    Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
                    Spacer()
                    VStack {
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
                    }
                    Spacer()
                }.padding()
            }
        }
        .onAppear {
            bottomSheet.showSheet = false
            timerController.setTimer(key: "statTimer", withInterval: 1) {
                statController.updateStats()
                statController.objectWillChange.send()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $fToast.toast)
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
