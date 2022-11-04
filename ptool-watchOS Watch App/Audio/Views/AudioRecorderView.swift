//
//  audioRecorderView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-13.
//

import SwiftUI
import AVFoundation
struct AudioRecorderView: View {
    
    @EnvironmentObject var audioRecorder: AudioRecorder
    @EnvironmentObject var db: AppManager

    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            VStack{
                VStack{
                    if audioRecorder.isRecording {
                        Text(NSLocalizedString("Enregistrement en cours...", comment: ""))
                            .font(Font.caption2)
                        Image(systemName: "waveform.and.mic")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color.green)
                        
                    } else if let cRecording = audioRecorder.currentRecording {
//                    } else if true {
                        NavigationLink(value: cRecording) {
                            HStack {
                                Spacer()
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
                        
                    } else {
                        Text(NSLocalizedString("Appuyer sur le bouton pour enregistrer un message vocal", comment: ""))
                            .lineLimit(4)
                        
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
//                .border(.green)
                VStack {
                    Spacer()
                    HStack {
                        // MARK: record Button
                        PlaybackControlButton(systemName: getRecordButtonSysName(),fontSize: geometry.size.width * 0.45, color: getRecordButtonColor(), action: recordButtonPerform)
                                            .frame(width: geometry.size.width * 0.5)
                            .frame(alignment: .bottom)
                        
                        Spacer()

                        // MARK: play-pause Button
                        if audioRecorder.currentRecording != nil {
                            if let url = audioRecorder.currentRecording?.fileURL {
                        
                                AudioPlayerView(url: url, mode: .buttonPlayOnly, playLooping: false, autoStart: false)
//                        AudioPlayerView(url: URL(filePath: "/"), mode: .buttonPlayOnly, playLooping: false, autoStart: false)
                                    .frame(width: geometry.size.width * 0.5)
                            }
                        }
                    }
                    .frame(alignment: .bottom)
                    .padding(.bottom, 0)
                    //            .padding(.top, 20)
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.45)
//                .border(.yellow)
            }
            
//            .border(.red)
            
            .navigationTitle(NSLocalizedString("nt-home", comment: ""))
            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            
        }
    }
    func getRecordButtonSysName() -> String {
        if audioRecorder.currentRecording != nil {
            return "trash.circle.fill"
        } else if audioRecorder.isRecording == false {
            return "record.circle.fill"
        } else {
            return "stop.circle.fill"
        }
    }
    func getRecordButtonColor() -> Color {
        if audioRecorder.currentRecording != nil {
            return .red
        } else if audioRecorder.isRecording == false {
            return .green
        } else {
            return .yellow
        }
    }
    func recordButtonPerform() {
        if audioRecorder.currentRecording != nil {
            audioRecorder.removeCurrentRecording()
        } else if audioRecorder.isRecording == false {
            audioRecorder.startRecording()
        } else {
            audioRecorder.stopRecording()
        }
    }
 }

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
            .environmentObject(AppManager())
            .environmentObject(AudioRecorder())
            .environmentObject(AudioManager())
    }
}
