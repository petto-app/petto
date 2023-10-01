//
//  SettingsController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 13/07/23.
//

import Foundation
import SwiftUI

class SettingsController: ObservableObject {
    @ObservedObject var settingsModel = SettingsModel.shared

    func getMute() -> Bool {
        return settingsModel.getMute()
    }

    func setMute(mute: Bool) {
        settingsModel.setMute(mute: mute)
    }

    func toggleMute() {
        setMute(mute: !getMute())
    }

    func getEnableNotification() -> Bool {
        return settingsModel.getEnableNotification()
    }

    func setEnableNotification(enableNotification: Bool) {
        settingsModel.setEnableNotification(enableNotification: enableNotification)
    }

    func toggleEnableNotification() {
        setEnableNotification(enableNotification: !getEnableNotification())
    }
}
