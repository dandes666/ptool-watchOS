//
//  AudioPlayerView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-29.
//

import SwiftUI

struct AudioPlayerView: View {
//    @EnvironmentObject var audioManager: AudioManager
    @StateObject private var audioManager = AudioManager()
    @Environment(\.dismiss) var dismiss
    
    var url: URL
    var mode: AudioPlayerMode = .standard
    var height: CGFloat?
    var width: CGFloat?
    var playLooping: Bool = true
    var autoStart: Bool = true
    
    var isPreview: Bool = false
    @State private var progress: Double = 0.0
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    var status: AudioPlayerStatus = AudioPlayerStatus.stop
    
    let timer = Timer
        .publish(every: 0.3, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            VStack {
                
                // MARK: Slider Control
                if mode == .standard {
                    //                        Slider(value: $value, in: 0...player.duration) { editing in
                    //                            isEditing = editing
                    //                            if !editing {
                    //                                player.currentTime = value
                    //                            }
                    //                        }
                }
                
                // MARK: play time
                if mode == .standard {
                    //                        HStack {
                    //                            Text(DateComponentsFormatter.positional.string(from: value) ?? "0:00")
                    //                            Spacer()
                    //                            Text(DateComponentsFormatter.positional.string(from: player.duration - value) ?? "0:00")
                    //                        }
                }
                
                // MARK: Button Control
//                ZStack {
//                    Color.blue
                    HStack {
                        Spacer()
                        // MARK: backward Button
                        if mode == .buttonAndDetail {
                            VStack {
                                PlaybackControlButton(systemName: "gobackward.5", fontSize: geometry.size.width * 0.17, action: audioManager.gobackward)
                                //                            Text(DateComponentsFormatter.positional.string(from: value) ?? "0:00").font(Font.caption2)
                                //                                .foregroundColor(audioManager.isPlaying ? .green : .yellow)
                            }
                            //                        .frame(width: geometry.size.width * 0.2)
                        }
                        Spacer()
                        
                        // MARK: playPause Button
                        
                        PlaybackControlButton(systemName: audioManager.status == AudioPlayerStatus.play ? "pause.circle.fill" : "play.circle.fill", fontSize: getPlayPauseSize(size: geometry.size), color: .white, action: audioManager.playPause, progress: progress,progressColor: audioManager.isPlaying ? .green : .yellow)

                        //                        .frame(width: geometry.size.width * 0.45)
                        Spacer()
                        
                        // MARK: forward Button
                        if mode == .buttonAndDetail {
                            VStack {
                                PlaybackControlButton(systemName: "goforward.5", fontSize: geometry.size.width * 0.17, action: audioManager.goforward)
                                //                            if let player = audioManager.player {
                                //                                Text(DateComponentsFormatter.positional.string(from: player.duration) ?? "0:00").font(Font.caption2)
                                //                            } else {
                                //                                Text("--:--").font(Font.caption2)
                                //                            }
                            }
                            //                        .frame(width: geometry.size.width * 0.2)
                        }
                        Spacer()
                    }
//                    .frame(width: geometry.size.width)
//                }
                HStack {
                    // MARK: Time Left
                    if mode == .buttonPLayAndTimeleft || mode == .buttonAndDetail {
                        Text(DateComponentsFormatter.positional.string(from: value) ?? "0:00").font(Font.caption2)
                            .foregroundColor(audioManager.isPlaying ? .green : .yellow)
                            .padding(.leading, 10)
                        
                        Spacer()
                        if let player = audioManager.player {
                            Text(DateComponentsFormatter.positional.string(from: player.duration) ?? "0:00").font(Font.caption2)
                                .padding(.trailing, 10)
                        } else {
                            Text("--:--").font(Font.caption2)
                                .padding(.trailing, 10)
                        }
                        
                    }
                }
            }
            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
        }
        .onAppear {
            if autoStart {
                audioManager.startPlayer(url: url, isPreview: isPreview)
            } else {
                audioManager.startPlayer(url: url, isPreview: true)
            }
            if playLooping {
                audioManager.startLooping()
            } else {
                audioManager.stopLooping()
            }
        }
            
        .onDisappear {
            audioManager.stopPlayer()
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return }
            value = player.currentTime
            self.progress =  player.currentTime / player.duration
            if !player.isPlaying && audioManager.isPlaying {
                
                audioManager.stopPlayer()
            }
//            print("currentTime= \(player.currentTime) duration= \(player.duration) progress= \(self.progress)")
            //                if !isEditing {
            //                    value = player.currentTime
            //                }
        }
        //        }
    }
    func getPlayPauseSize(size: CGSize) -> CGFloat {
        switch mode {
        case .standard:
            return size.width * 0.4
        case .buttonPlayOnly:
            return size.width
        case .buttonPLayAndTimeleft:
            return size.width
        case .buttonAndDetail:
            return size.width * 0.4
        }
    }
    func getButtonImageName(aStatus: AudioPlayerStatus) -> String {
        switch aStatus {
        case .stop:
            return "stop.circle.fill"
        case .play:
            return "play.circle.fill"
        case .pause:
            return "pause.circle.fill"
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentPath.appendingPathComponent("memo-29-10-22_at_13:38:59.m4a")

        NavigationStack {
            ZStack{
                Color.brown
                    .frame(width: 175, height: 140)
                AudioPlayerView(url: url, mode: .buttonAndDetail, height: 100, width: 100, isPreview: true)
                    .environmentObject(AppManager())
                    .environmentObject(AudioManager())
                    .frame(width: 175, height: 140)
            }
        }
    }
}
