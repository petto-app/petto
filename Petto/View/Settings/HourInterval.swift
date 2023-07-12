//
//  HourInterval.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 07/07/23.
//

import SwiftUI

struct HourInterval: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var bottomSheet: BottomSheet

    @StateObject var timeController: TimeController = .init()
    @State private var interval = 2
    @State private var startHour = "09"
    @State private var finishHour = "17"
    @State private var isGameCenterOpen = false

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var gameKitController: GameKitController

    var body: some View {
        VStack {
            ZStack {
                Image("SettingsBg").resizable().ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image("Arrow").resizable().frame(width: 22, height: 22)
                        }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                        Spacer()
                        PrimeTime().opacity(0)
                    }
                    SettingsHeaderButton(width: 60, height: 60, title: "Working Hour & Interval", image: "Clock", active: true) {}
                    SettingsContainer(intervalSelection: $interval, startSelection: $startHour, finishSelection: $finishHour)
                        .padding(.bottom)
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
        .sheet(isPresented: $isGameCenterOpen) {
            GameCenterView()
                .ignoresSafeArea()
        }
    }
}

struct HourInterval_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var fToast = FancyToastClass()
        @StateObject var statController = StatController()
        @StateObject var gameKitController = GameKitController()
        @StateObject var bottomSheet = BottomSheet()
        HourInterval().environmentObject(fToast)
            .environmentObject(statController)
            .environmentObject(gameKitController)
            .environmentObject(bottomSheet)
    }
}
