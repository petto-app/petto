//
//  Home.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 21/06/23.
//

import SpriteKit
import SwiftUI
import UserNotifications

struct Home: View {
    @EnvironmentObject var timeController: TimeController
    @EnvironmentObject var healthKitController: HealthKitController
    @EnvironmentObject var bottomSheet: BottomSheet
    @State private var idleFrameNames: [String] = ["shiba-1"]
    @EnvironmentObject var dailyTaskController: DailyTaskController
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var timerController: TimerController
    @AppStorage("coin") var coin: Int?
    @AppStorage("totalCoin") var totalCoin: Int?

    func getWp() -> String {
        switch statController.hygiene {
        case 0 ... 20:
            return "wp3"
        case 21 ... 50:
            return "wp2"
        default:
            return "wp"
        }
    }

    func updateFrames() {
        switch (statController.energy, statController.fun) {
        case (0 ... 20, 0 ... 20):
            idleFrameNames = ["shiba-7"]
        case (21 ... 50, 0 ... 20):
            idleFrameNames = ["shiba-3"]
        case (51 ... 100, 0 ... 20):
            idleFrameNames = ["shiba-3"]
        case (0 ... 20, 21 ... 50):
            idleFrameNames = ["shiba-6"]
        case (21 ... 50, 21 ... 50):
            idleFrameNames = ["shiba-6"]
        case (51 ... 100, 21 ... 50):
            idleFrameNames = ["shiba-2"]
        case (0 ... 20, 51 ... 100):
            idleFrameNames = ["shiba-5"]
        case (21 ... 50, 51 ... 100):
            idleFrameNames = ["shiba-4"]
        case (51 ... 100, 51 ... 100):
            idleFrameNames = ["shiba-1"]
        default:
            idleFrameNames = ["shiba-1"]
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image(getWp()).resizable().ignoresSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    Avatar(idleFrameNames: $idleFrameNames, scale: 1.2)
                    VStack {
                        HStack {
                            NavigationLink {
                                Settings()
                            } label: {
                                Image("SettingsIcon").resizable().frame(width: 22, height: 22)
                            }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                            Coin(coin: coin ?? 0, totalCoin: totalCoin ?? 0).offset(y: 20)
                            Spacer()
                            PrimeTime().offset(x: -25, y: 20)
                        }
                        Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
                        HStack {
                            Spacer()
                            VStack {
                                if timeController.isPrimeTime() {
                                    Button {
                                        print("Button pressed!")
                                    } label: {
                                        Image("exclamation").resizable(
                                        )
                                        .scaledToFit().frame(width: 40, height: 40)
                                    }.buttonStyle(IconButtonRect(width: 50, height: 50))
                                }
                                NavigationLink {
                                    Shop()
                                } label: {
                                    Image("ShopIcon").resizable(
                                    )
                                    .scaledToFit().frame(width: 35, height: 35)
                                }.buttonStyle(IconButtonRect(width: 50, height: 50))
                                NavigationLink {
                                    BMView()
                                } label: {
                                    Text("BMS")
                                        .font(.caption)
                                }.buttonStyle(IconButtonRect(width: 50, height: 50))
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }.onAppear {
                bottomSheet.showSheet = true
                let idleFrameAtlas = SKTextureAtlas(named: "IdleFrames")
                // idleFrameNames = idleFrameAtlas.textureNames.sorted()
                GSAudio.sharedInstance.playSound(soundFileName: "background", numberOfLoops: -1)
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }

                timerController.setTimer(key: "statTimer", withInterval: 1) {
                    statController.updateStats()
                    statController.objectWillChange.send()
                    updateFrames()
                }
            }
            .sheet(isPresented: $bottomSheet.showSheet) {
                ScrollView {
                    VStack {
                        Text("Daily Tasks").fontWeight(.bold)

                        DailyTask(dailyTasks: $dailyTaskController.dailyTaskModel.dailyTasks)
                    }
                }.presentationDetents([.fraction(0.15), .fraction(0.38)]).interactiveDismissDisabled(true)
                    .presentationBackground(Color("TaskSheet"))
                    .presentationBackgroundInteraction(
                        .enabled
                    )
                    .presentationCornerRadius(24)
                    .padding(.top, 16)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
