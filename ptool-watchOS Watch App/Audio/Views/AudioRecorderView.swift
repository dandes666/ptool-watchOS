//
//  audioRecorderView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-13.
//

import SwiftUI
import AVFoundation
struct AudioRecorderView: View {
    
//    @ObservedObject var audioRecorder: AudioRecorder
    @EnvironmentObject var audioRecorder: AudioRecorder
    @EnvironmentObject var db: AppManager

    
    var body: some View {

        VStack{
            if audioRecorder.isRecording {
                Text(NSLocalizedString("Enregistrement en cours...", comment: ""))
            } else if let cRecording = audioRecorder.currentRecording {
                NavigationLink(value: cRecording) {
                    HStack {
                        RecordingView(rec: cRecording)
                        Spacer()
                        Image("next")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .leading)
                    }
                }
                .navigationDestination(for: Recording.self) { rec in
                    RecordingShareMenuView(rec: rec)
                }
                
//                .onDisappear() {
//                    print("trace onDisappear 1")
//                }
            } else {
                Text(NSLocalizedString("Appuyer sur le bouton pour enregistrer un message vocal", comment: ""))
                    .lineLimit(4)
                
            }
            Spacer()
                .navigationTitle(NSLocalizedString("nt-home", comment: ""))
            HStack {
                if audioRecorder.currentRecording != nil {
                    Button(action: {audioRecorder.removeCurrentRecording()}) {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .foregroundColor(.red)
                    }
                    .frame(width: 80, height: 80)
                } else if audioRecorder.isRecording == false {
                    Button(action: {audioRecorder.startRecording()}) {
                        Image(systemName: "record.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .foregroundColor(.red)
                    }
                    .frame(width: 80, height: 80)
                } else {
                    Button(action: {audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipped()
                            .foregroundColor(.yellow)
//                                .padding(.bottom, 40)
                    }.frame(width: 80, height: 80)
                }
                Spacer()
                if audioRecorder.currentRecording != nil && !audioRecorder.isRecording {
//                    Button(action: {audioRecorder.playBack()}) {
//                        Image(systemName: "play.circle.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 80, height: 80)
//                            .clipped()
//                            .foregroundColor(.green)
//                    }.frame(width: 80, height: 80)
                    if let url = audioRecorder.currentRecording?.fileURL {
                        AudioPlayerView(url: url, mode: .buttonPlayOnly, playLooping: false, autoStart: false)
                    }
                }
            }

        }
        
    }
}
//struct RecordingRow: View {
//    
//    var audioURL: URL
//    
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Text("\(audioURL.lastPathComponent)")
//                Spacer()
//            }
//            Button(action: {playSound(url: audioURL)}) {
//                Text("play")
//            }
//        }
//    }
////    func playAudio() -> Void {
////        print("trace playAudio")
////        print(audioURL)
////        print("baseUrl = \(audioURL.baseURL)")
//////        let test = URL(filePath: "/data/Containers/Data/Application/85EC7A9A-B5CE-496D-9065-D93806CAE7A3/Documents/15-10-22_at_14:23:57.m4a")
////        playSound(url: audioURL)
//////        playSound(url: test)
//////        var audioPlayer: AVAudioPlayer?
////////        var avPlayer: AVPlayer?
//////        do {
////////            let asset  = AVURLAsset(url: audioURL, options: nil)
////////            let item = AVPlayerItem(asset: asset)
////////            avPlayer = AVPlayer(playerItem: item)
////////            avPlayer?.play()
//////
//////            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
////////            audioPlayer?.delegate = self
//////            audioPlayer?.numberOfLoops = .max
//////            audioPlayer?.prepareToPlay()
//////            audioPlayer?.play()
//////        } catch {
//////            // couldn't load file :(
//////        }
////        return
////    }
//    
//}
struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}
