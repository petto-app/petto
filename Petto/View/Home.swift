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
    @State private var idleFrameNames: [String] = []
    @State var isGameCenterOpen: Bool = false
    @EnvironmentObject var dailyTaskController: DailyTaskController
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var timerController: TimerController
    @AppStorage("coin") var coin: Int?
    @AppStorage("totalCoin") var totalCoin: Int?

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("wp").resizable().ignoresSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    Avatar(idleFrameNames: $idleFrameNames)
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
                                Button {
                                    isGameCenterOpen = true
                                } label: {
                                    Text("Game Center")
                                        .font(.caption)
                                }
                                .buttonStyle(IconButtonRect(width: 50, height: 50))
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }.onAppear {
                bottomSheet.showSheet = true
                let idleFrameAtlas = SKTextureAtlas(named: "IdleFrames")
                idleFrameNames = idleFrameAtlas.textureNames.sorted()
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
                    .sheet(isPresented: $isGameCenterOpen) {
                        GameCenterView()
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
