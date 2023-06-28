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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shopViewController)
                .environmentObject(timeController)
                .environmentObject(healthKitController)
                .environmentObject(FancyToastClass())
                .environmentObject(bottomSheet)
                .environmentObject(dailyTaskController)
        }
    }
}
