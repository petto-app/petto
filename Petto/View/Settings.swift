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
                        Coin(coin: 100, totalCoin: 1000).offset(y: 20)
                        Spacer()
                        PrimeTime().offset(x: -5, y: 20)
                    }
                    Stats().offset(y: -20)
                    SettingsContainer(intervalSelection: $interval, startSelection: $startHour, finishSelection: $finishHour)
                        .padding(.bottom)
                    Button("Save") {
                        print(startHour)
                        print(interval)
                        let res = timeController.setPrimeTime(start: Int(startHour) ?? 9, finish: Int(finishHour) ?? 17, interval: interval)
                        if !res {
                            fToast.toast = FancyToast(type: .error, title: "Error", message: "Invalid input", duration: 3)
                        } else {
                            fToast.toast = FancyToast(type: .success, title: "Success", message: "Settings saved", duration: 3)
                        }
                    }
                    .buttonStyle(MainButton(width: 80))
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
        Settings().environmentObject(FancyToastClass())
    }
}
