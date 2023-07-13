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
    @EnvironmentObject var audioController: AudioController
    @EnvironmentObject var healthKitController: HealthKitController
    @EnvironmentObject var bottomSheet: BottomSheet
    @State private var idleFrameNames: [String] = ["shiba-1"]
    @EnvironmentObject var dailyTaskController: DailyTaskController
    @EnvironmentObject var statController: StatController
    @EnvironmentObject var timerController: TimerController
    @EnvironmentObject var characterController: CharacterController
    @EnvironmentObject var popUpModel: PopUpModel
    @AppStorage("coin") var coin: Int?
    @AppStorage("totalCoin") var totalCoin: Int?
    @AppStorage("mute") var mute: Bool = false
    @AppStorage("isOnBoarded") var isOnBoarded: Bool?
    
    @State private var dialogMessage: String? = nil
    @State private var bodyMovementImages: [String] = []

    func getImageName(index: Int) -> String {
        if characterController.getCharacter() == "dog" {
            return "shiba-\(index)"
        }
        return "cat-\(index)"
    }

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
            idleFrameNames = [getImageName(index: 7)]
        case (21 ... 50, 0 ... 20):
            idleFrameNames = [getImageName(index: 3)]
        case (51 ... 100, 0 ... 20):
            idleFrameNames = [getImageName(index: 3)]
        case (0 ... 20, 21 ... 50):
            idleFrameNames = [getImageName(index: 6)]
        case (21 ... 50, 21 ... 50):
            idleFrameNames = [getImageName(index: 6)]
        case (51 ... 100, 21 ... 50):
            idleFrameNames = [getImageName(index: 2)]
        case (0 ... 20, 51 ... 100):
            idleFrameNames = [getImageName(index: 5)]
        case (21 ... 50, 51 ... 100):
            idleFrameNames = [getImageName(index: 4)]
        case (51 ... 100, 51 ... 100):
            idleFrameNames = [getImageName(index: 1)]
        default:
            idleFrameNames = [getImageName(index: 1)]
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        Image(getWp()).resizable().ignoresSafeArea(.all)
                            .aspectRatio(contentMode: .fill)
                    }
                    Avatar(idleFrameNames: $idleFrameNames, scale: 1.2, poopCount: statController.hygiene <= 20 ? ((20 - statController.hygiene) / 5 + 1) : 0)
                    VStack {
                        HStack {
                            NavigationLink {
                                Settings()
                            } label: {
                                Image("SettingsIcon").resizable().frame(width: 22, height: 22)
                            }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                            Coin(coin: coin ?? 0, totalCoin: totalCoin ?? 0).offset(y: 20)
                            Spacer()
                            PrimeTime().offset(x: -25, y: 20).opacity(timeController.isPrimeTime() ? 1 : 0)
                        }
                        Stats(fun: $statController.statModel.fun.amount, hygiene: $statController.statModel.hygiene.amount, energy: $statController.statModel.energy.amount).offset(y: -20)
                        HStack {
                            Spacer()
                            VStack {
                                NavigationLink {
                                    Shop()
                                } label: {
                                    Image("ShopIcon").resizable(
                                    )
                                    .scaledToFit().frame(width: 35, height: 35)
                                }.buttonStyle(IconButtonRect(width: 50, height: 50))
                                NavigationLink {
                                    ZStack{
                                        BMView(dialogMessage: $dialogMessage, bodyMovementImages: $bodyMovementImages)
                                            .ignoresSafeArea()
                                            .environmentObject(StatModel.shared)
                                            .environmentObject(BodyMovementTaskModel.shared)
                                        
                                        if dialogMessage != nil {
                                            Dialog(message: dialogMessage!)
                                                .offset(x: 0, y:100)
                                        }
                                        
                                        // TODO: Change the size of animated character frames
//                                        Image("shiba-1")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 240)
//                                            .padding()
//                                            .offset(x: 70, y: 245)
                                        
                                        if bodyMovementImages.count > 0 {
                                            Avatar(idleFrameNames: $bodyMovementImages)
                                            .padding()
                                            .offset(x: 70, y: 245)
                                        }
                                    }
                                } label: {
                                    Text("BMS")
                                        .font(.caption)
                                }.buttonStyle(IconButtonRect(width: 50, height: 50))
                                if timeController.isPrimeTime() {
                                    PulseButton(color: .red) {
                                        Button {
                                            print("Button pressed!")
                                        } label: { PulseButton(color: .red) {
                                            Image("exclamation").resizable(
                                            )
                                            .scaledToFit().frame(width: 40, height: 40)
                                        }
                                        }.buttonStyle(IconButtonRect(width: 50, height: 50))
                                    }
                                }
                            }
                        }
                        Spacer()
                    }.padding()
                    if popUpModel.isExists() {
                        Color.black.opacity(0.75)
                            .ignoresSafeArea()
                            .overlay(
                                ForEach(popUpModel.popUpItems.indices, id: \.self) { index in
                                    if popUpModel.popUpItems[index].state != .hidden {
                                        PopUp(popUp: popUpModel.popUpItems[index])
                                            .zIndex(Double(popUpModel.popUpItems.count - index)) // Adjust the order of overlays
                                            .transition(.slide)
                                            .animation(.easeInOut)
                                            .id(popUpModel.popUpItems[index].id)
                                    }
                                }
                            )
                    }
                }
            }.onAppear {
                isOnBoarded = true
                bottomSheet.showSheet = true
                statController.updateStats()
                statController.objectWillChange.send()
                updateFrames()
                // let idleFrameAtlas = SKTextureAtlas(named: "IdleFrames")
                // idleFrameNames = idleFrameAtlas.textureNames.sorted()
                audioController.audioPlayer.stopAllSounds()
                audioController.audioPlayer.playSound(soundFileName: statController.fun < 20 ? "bg-no-fun" : "bg-full", numberOfLoops: -1)
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

                if mute {
                    audioController.audioPlayer.mute()
                } else {
                    audioController.audioPlayer.unmute()
                }
            }
            .sheet(isPresented: $bottomSheet.showSheet) {
                ScrollView {
                    VStack {
                        Text("Daily Tasks").fontWeight(.bold).padding(.bottom, 20)

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
        @StateObject var shopViewController = ShopViewController()
        @StateObject var timeController = TimeController()
        @StateObject var healthKitController = HealthKitController()
        @StateObject var bottomSheet = BottomSheet()
        @StateObject var dailyTaskController = DailyTaskController()
        @StateObject var statController = StatController()
        @StateObject var timerController = TimerController()
        @StateObject var gameKitController = GameKitController()
        @StateObject var fancyToast = FancyToastClass()
        @StateObject var popUpModel = PopUpModel()

        Home()
            .environmentObject(gameKitController)
            .environmentObject(shopViewController)
            .environmentObject(timeController)
            .environmentObject(healthKitController)
            .environmentObject(fancyToast)
            .environmentObject(bottomSheet)
            .environmentObject(dailyTaskController)
            .environmentObject(statController)
            .environmentObject(timerController)
            .environmentObject(popUpModel)
    }
}
