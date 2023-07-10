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

    func getPrice() -> Int {
        return amounts[0] * 5 + amounts[1] * 10 + amounts[2] * 50 + amounts[3] * 100
    }

    func isPlusDisabled(price: Int) -> Bool {
        return getPrice() + price > (coin ?? 0)
    }

    func getProjectedValue(type: ShopItemType) -> Int {
        if itemType != type {
            return 0
        }
        return getPrice()
    }

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
                        PrimeTime(timerKey: "primeTimeTimerShop").offset(x: -25, y: 20).opacity(0)
                    }
                    Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount, funProjection: getProjectedValue(type: .fun), hygieneProjection: getProjectedValue(type: .hygiene), energyProjection: getProjectedValue(type: .energy)).offset(y: -20)
                    Spacer()
                    VStack {
                        ShopTab(activeType: $itemType, amounts: $amounts)
                        Group {
                            LazyVGrid(columns: columns) {
                                ForEach(Array(shopViewController.getAll().filter { $0.type == itemType }.enumerated()), id: \.element) { index, shopItem in
                                    if shopItem.type == itemType {
                                        ShopItemComponent(price: shopItem.price, image: shopItem.image, amount: $amounts[index], plusDisabled: isPlusDisabled(price: shopItem.price))
                                    }
                                }
                            }
                        }
                        Button("Buy") {
                            if !isTransactionValid() {
                                return
                            }
                            for (index, shopItem) in Array(shopViewController.getAll().filter { $0.type == itemType }.enumerated()) {
                                if shopItem.type == itemType {
                                    for _ in 0 ..< amounts[index] { shopViewController.buy(shopItem: shopItem)
                                    }
                                }
                            }

                            GSAudio.sharedInstance.playSound(soundFileName: "kaching")

                            func resetAmounts() {
                                for i in 0 ..< amounts.count {
                                    amounts[i] = 0
                                }
                            }
                        }
                        .buttonStyle(MainButton(width: 70, height: 10))
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
            GSAudio.sharedInstance.stopAllSounds()
            print("WOWIIWOWIW")
            GSAudio.sharedInstance.playSound(soundFileName: "bg-shop", numberOfLoops: -1)
        }
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $fToast.toast)
    }

    func isTransactionValid() -> Bool {
        if (amounts.allSatisfy { $0 == 0 }) {
            fToast.toast = FancyToast(type: .error, title: "Error", message: "Please buy at least 1 item", duration: 3)
            return false
        }
        return true
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
