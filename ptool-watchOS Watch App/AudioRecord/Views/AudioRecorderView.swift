//
//  audioRecorderView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-13.
//

import SwiftUI
import AVFoundation
struct AudioRecorderView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @EnvironmentObject var db: AppManager
//    let ar = AVAudioRecorder()

    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .chocolate
    
    
    var body: some View {
        
        NavigationView {
            VStack{
//                List {
//                    ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
//                        RecordingRow(audioURL: recording.fileURL)
//                    }
//                }
                if audioRecorder.isRecording {
                    Text(NSLocalizedString("Enregistrement en cours...", comment: ""))
                } else if let cRecording = audioRecorder.currentRecording {
                    NavigationLink(destination: RecordingShareMenuView(rec: cRecording, audioRecorder: audioRecorder)) {
                        HStack {
                            RecordingView(rec: cRecording)
                            Spacer()
                            Image("next")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .leading)
                        }
                    }
                    .onDisappear() {
                        print("trace onDisappear 1")
                    }
                } else {
                    Text(NSLocalizedString("Appuyer sur le bouton pour enregistrer un message vocal", comment: ""))
                        .lineLimit(4)
                    
                }
                Spacer()
                HStack {
                    if audioRecorder.currentRecording != nil {
                        Button(action: {self.audioRecorder.removeCurrentRecording()}) {
                            Image(systemName: "trash.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .foregroundColor(.red)
                        }
                        .frame(width: 80, height: 80)
                    } else if audioRecorder.isRecording == false {
                        Button(action: {self.audioRecorder.startRecording()}) {
                            Image(systemName: "record.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .foregroundColor(.red)
                        }
                        .frame(width: 80, height: 80)
                    } else {
                        Button(action: {self.audioRecorder.stopRecording()}) {
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
                        Button(action: {self.audioRecorder.playBack()}) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .foregroundColor(.green)
                            //                                .padding(.bottom, 40)
                        }.frame(width: 80, height: 80)
                    }
                }

            }
        }
//        .navigationTitle("Recorder")
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
        AudioRecorderView(audioRecorder: AudioRecorder())
    }
}
