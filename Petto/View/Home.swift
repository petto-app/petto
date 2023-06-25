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
                                Image(systemName: "gearshape")
                            }.buttonStyle(IconButton(width: 30, height: 30)).offset(y: 20)
                            Coin(coin: 100, totalCoin: 1000).offset(y: 20)
                            Spacer()
                            PrimeTime().offset(x: -5, y: 20)
                        }
                        Stats().offset(y: -20)
                        HStack {
                            Spacer()
                            VStack {
                                if isPrimeTime(hours: getPrimeTimeHours(startHour: 9, endHour: 17, intervalHour: 2)) {
                                    Button {
                                        print("Button pressed!")
                                    } label: {
                                        Image("exclamation")
                                    }.buttonStyle(IconButton(width: 50, height: 50))
                                }
                                Button {
                                    print("Button pressed!")
                                } label: {
                                    Image("ShopIcon")
                                }.buttonStyle(IconButton(width: 50, height: 50))
                                Button {
                                    isGameCenterOpen = true
                                } label: {
                                    Text("Game Center")
                                        .font(.caption)
                                }
                                .buttonStyle(IconButton(width: 50, height: 50))
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }.onAppear {
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
//                timeController.setPrimeTime(start: 10)
                print(timeController.getPrimeTime())
//                print(scheduleLocal(startHour: 9, endHour: 17, intervalHour: 2))
            }
            .sheet(isPresented: $isGameCenterOpen) {
                GameCenterView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
