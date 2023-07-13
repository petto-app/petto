//
//  AudioController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 13/07/23.
//

import Foundation
import SwiftUI

class AudioController: ObservableObject {
    @ObservedObject var audioPlayer = GSAudio.sharedInstance
}
