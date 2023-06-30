//
//  Settings.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bottomSheet: BottomSheet

    @StateObject var timeController: TimeController = .init()
    @State private var interval = 2
    @State private var startHour = "09"
    @State private var finishHour = "17"

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var gameKitController: GameKitController

    var body: some View {
        VStack {
            ZStack {
                Image("SettingsBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.22)
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Spacer()
                        PrimeTime().opacity(0)
                    }
                    SettingsContainer(intervalSelection: $interval, startSelection: $startHour, finishSelection: $finishHour)
                        .padding(.bottom).offset(y: -20)
                    Button("Save") {
                        let res = timeController.setPrimeTime(start: Int(startHour) ?? 9, finish: Int(finishHour) ?? 17, interval: interval)
                        if !res {
                            fToast.toast = FancyToast(type: .error, title: "Error", message: "Invalid input", duration: 3)
                        } else {
                            fToast.toast = FancyToast(type: .success, title: "Success", message: "Settings saved", duration: 3)
                        }
                    }
                    .buttonStyle(MainButton(width: 80))
                    Group {
                        Button("<Test> Increase Fun") {
                            statController.increaseFun(amount: 5)
                        }
                        Button("<Test> Decrease Fun") {
                            statController.decreaseFun(amount: 5)
                        }
                        Button("<Test> Increase Hygiene") {
                            statController.increaseHygiene(amount: 5)
                        }
                        Button("<Test> Decrease Hygiene") {
                            statController.decreaseHygiene(amount: 5)
                        }
                        Button("<Test> Increase Energy") {
                            statController.increaseEnergy(amount: 5)
                        }
                        Button("<Test> Decrease Energy") {
                            statController.decreaseEnergy(amount: 5)
                        }
                        Button("<Test> Increase Coin") {
                            statController.increaseCoin(amount: 100)
                            gameKitController.reportScore(totalCoin: statController.totalCoin)
                        }
                        Button("<Test> Decrease Coin") {
                            statController.decreaseCoin(amount: 100)
                        }
                    }
                    Spacer()
                }.padding()
            }
        }
        .onAppear {
            bottomSheet.showSheet = false
            let primeTime = timeController.getPrimeTime()
            startHour = String(format: "%02d", primeTime?.startHour ?? 9)
            finishHour = String(format: "%02d", primeTime?.finishHour ?? 17)
            interval = primeTime?.interval ?? 2
        }
        .navigationBarBackButtonHidden(true)
        .toastView(toast: $fToast.toast)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var fancyToast = FancyToastClass()
        Settings().environmentObject(fancyToast)
    }
}
