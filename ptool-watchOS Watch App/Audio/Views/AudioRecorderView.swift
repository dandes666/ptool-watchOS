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

        VStack{
            if audioRecorder.isRecording {
                Text(NSLocalizedString("Enregistrement en cours...", comment: ""))
            } else if let cRecording = audioRecorder.currentRecording {
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
            Spacer()
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
//                if audioRecorder.currentRecording != nil && !audioRecorder.isRecording {
                if audioRecorder.currentRecording != nil {
                    if let url = audioRecorder.currentRecording?.fileURL {
                        AudioPlayerView(url: url, mode: .buttonPlayOnly, playLooping: false, autoStart: false)
                    }
                }
            }
            .padding(.bottom, 0)
        }
        .navigationTitle(NSLocalizedString("nt-home", comment: ""))
    }
}

struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
            .environmentObject(AppManager())
            .environmentObject(AudioRecorder())
    }
}
