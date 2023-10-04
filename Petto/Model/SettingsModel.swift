//
//  SettingsModel.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 13/07/23.
//

import Foundation
import SwiftUI

struct SettingsStruct: Codable {
    public var mute: Bool
}

class SettingsModel: ObservableObject {
    public static var shared: SettingsModel = .init()
    @AppStorage("mute")
    var mute: Bool = false

    init() {}

    func setMute(mute: Bool) {
        self.mute = mute
    }

    func getMute() -> Bool {
        return mute
    }

    @AppStorage("enableNotification")
    var enableNotification: Bool = true

    func setEnableNotification(enableNotification: Bool) {
        self.enableNotification = enableNotification
    }

    func getEnableNotification() -> Bool {
        return enableNotification
    }
}
