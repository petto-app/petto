//
//  Settings.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var settingsController: SettingsController
    @EnvironmentObject var bottomSheet: BottomSheet
    @EnvironmentObject var audioController: AudioController

    @StateObject var timeController: TimeController = .init()
    @State private var interval = 2
    @State private var startHour = "09"
    @State private var finishHour = "17"
    @State private var isGameCenterOpen = false

    @EnvironmentObject var fToast: FancyToastClass
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var gameKitController: GameKitController
    @EnvironmentObject var healthKitController: HealthKitController

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
                    Grid {
                        GridRow {
                            SettingsHeaderButton(width: 60, height: 60, title: "Leaderboard", image: "Leaderboard") {
                                isGameCenterOpen = true
                            }
                        }
                        GridRow {
                            SettingsHeaderButton(width: 60, height: 60, title: !settingsController.getMute() ? "Mute" : "Unmute", image: !settingsController.getMute() ? "SoundOff" : "SoundOn") {
                                if !settingsController.getMute() {
                                    audioController.audioPlayer.mute()
                                } else {
                                    audioController.audioPlayer.unmute()
                                }
                                settingsController.toggleMute()
                                settingsController.objectWillChange.send()
                            }
                        }
                        GridRow {
                            SettingsHeaderButton(width: 60, height: 60, title: settingsController.getEnableNotification() ? "Disable Notification" : "Enable Notification", image: settingsController.getEnableNotification() ? "bell.slash.fill" : "bell.fill", sf: true) {
                                settingsController.toggleEnableNotification()
                                _ = timeController.setPrimeTime()
                                settingsController.objectWillChange.send()
                            }
                        }
                        GridRow {
                            SettingsHeader(width: 60, height: 60, title: "Working Hour & Interval", image: "Clock", link: HourInterval())
                        }
                        GridRow {
                            SettingsHeader(width: 60, height: 60, title: "Character", image: "Paw", link: ChooseCharacter())
                        }
                    }.frame(width: UIScreen.main.bounds.size.width * 0.8)
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

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var fToast = FancyToastClass()
        @StateObject var statController = StatController()
        @StateObject var gameKitController = GameKitController()
        @StateObject var bottomSheet = BottomSheet()
        Settings().environmentObject(fToast)
            .environmentObject(statController)
            .environmentObject(gameKitController)
            .environmentObject(bottomSheet)
    }
}
