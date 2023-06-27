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
                            Coin(coin: 100, totalCoin: 1000).offset(y: 20)
                            Spacer()
                            PrimeTime().offset(x: -5, y: 20)
                        }
                        Stats().offset(y: -20)
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
                                Button {
                                    print("Button pressed!")
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
                // Health Kit
                healthKitController.authorizeHealthKit()
            }
            .sheet(isPresented: $bottomSheet.showSheet) {
                Text("Daily Tasks").fontWeight(.bold)
                    .presentationDetents([.fraction(0.15), .fraction(0.4)]).interactiveDismissDisabled(true)
                    .presentationBackground(Color("TaskSheet"))
                    .presentationBackgroundInteraction(
                        .enabled
                    )
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
