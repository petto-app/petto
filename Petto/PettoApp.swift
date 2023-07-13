//
//  PettoApp.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 18/06/23.
//

import SwiftUI

@main
struct PettoApp: App {
    // Initiate controller
    @StateObject var shopViewController = ShopViewController()
    @StateObject var timeController = TimeController()
    @StateObject var healthKitController = HealthKitController()
    @StateObject var bottomSheet = BottomSheet()
    @StateObject var dailyTaskController = DailyTaskController()
    @StateObject var statController = StatController()
    @StateObject var timerController = TimerController()
    @StateObject var gameKitController = GameKitController()
    @StateObject var characterController = CharacterController()
    @StateObject var settingsController = SettingsController()
    @StateObject var audioController = AudioController()
    @StateObject var fancyToast = FancyToastClass()
    @StateObject var popUpModel = PopUpModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
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
                .environmentObject(characterController)
                .environmentObject(settingsController)
                .environmentObject(audioController)
        }
    }
}
