//
//  AudioManager.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import Foundation
import AVKit
import AVFAudio
import Combine

final class AudioManager: ObservableObject {
    let objectWillChange = PassthroughSubject<AudioManager, Never>()
//    static let shared = AudioManager()
    var player: AVAudioPlayer?
    @Published private(set) var status: AudioPlayerStatus = AudioPlayerStatus.stop {
        didSet {
//            print("AudioPlayerStatus", status)
            objectWillChange.send(self)
        }
    }
    
//    @Published private(set) var isPlaying: Bool = false {
    @Published private(set) var isLooping: Bool = false
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            print("isPlaying", isPlaying)
            objectWillChange.send(self)
        }
    }
    func startPlayer(url: URL, isPreview: Bool = false) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let recordUrl = documentPath.appendingPathComponent(url.absoluteURL.lastPathComponent)
            player = try AVAudioPlayer(contentsOf: recordUrl)
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
                status = .play
            }
        } catch {
            print("erreur initilize player", error)
        }
    }
    func playPause() {
        guard let player = player else {
            print("instance of audio player not found")
            return
        }
        if player.isPlaying {
            player.pause()
            isPlaying = false
            status = .pause
        } else {
            player.play()
            isPlaying = true
            status = .play
        }
    }
    func stopPlayer() {
        guard let player = player else { return }
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
        status = .stop
    }
    func goforward() {
        guard let player = player else { return }
        player.currentTime += 5
    }
    func gobackward() {
        guard let player = player else { return }
        player.currentTime -= 5
    }
    func toogleLooping() {
        guard let player = player else { return }
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
    }
    func startLooping() {
        guard let player = player else { return }
        player.numberOfLoops = -1
        isLooping = false
    }
    func stopLooping() {
        guard let player = player else { return }
        player.numberOfLoops = 0
        isLooping = false
    }
 }
