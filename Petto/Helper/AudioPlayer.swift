//
//  AudioPlayer.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import AVFoundation
import Foundation

class GSAudio: NSObject, AVAudioPlayerDelegate {
    static let sharedInstance = GSAudio()

    override private init() {}

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0) {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { // player for sound has been found
            if !player.isPlaying { // player is not in use, so use that one
                player.numberOfLoops = numberOfLoops
                player.prepareToPlay()
                player.play()
            }
        } else { // player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.numberOfLoops = numberOfLoops
                player.prepareToPlay()
                player.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playSounds(soundFileNames: [String]) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: String...) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: [String], withDelay: Double) { // withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay * Double(index)
            _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
        }
    }

    @objc func playSoundNotification(_ notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
}
