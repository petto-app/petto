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

    @State var amounts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @State var itemType = ShopItemType.energy

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

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
                            Image("Arrow").resizable().frame(width: 22, height: 22)
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Coin(coin: coin ?? 0, totalCoin: totalCoin ?? 0).offset(y: 20)
                        Spacer()
                        PrimeTime(timerKey: "primeTimeTimerShop").offset(x: -25, y: 20)
                    }
                    Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
                    Spacer()
                    VStack {
                        ShopTab(activeType: $itemType)
                        Group {
                            LazyVGrid(columns: columns) {
                                ForEach(Array(shopViewController.getAll().filter { $0.type == itemType }.enumerated()), id: \.element) { index, shopItem in
                                    if shopItem.type == itemType {
                                        ShopItemComponent(price: shopItem.price, image: shopItem.image, amount: $amounts[index])
                                    }
                                }
                            }
                        }
                        Button("Buy") {
                            for (index, shopItem) in Array(shopViewController.getAll().filter { $0.type == itemType }.enumerated()) {
                                if shopItem.type == itemType {
                                    for _ in 0 ..< amounts[index] { shopViewController.buy(shopItem: shopItem)
                                    }
                                }
                            }
                        }
                        .buttonStyle(MainButton(width: 80))
                        .padding(.top, 40)
                    }.frame(width: UIScreen.main.bounds.size.width * 0.7).padding(.top, 80)
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
        @StateObject var fancyToastClass = FancyToastClass()

        Shop()
            .environmentObject(shopViewController)
            .environmentObject(statController)
            .environmentObject(fancyToastClass)
    }
}
