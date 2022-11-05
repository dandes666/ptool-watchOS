//
//  AudioRecorder.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-14.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation
import AVFAudio
import AVKit

class AudioRecorder: NSObject,ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()
    @Published var currentRecording: Recording? {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var isRecording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    var recordFileName: String? {
        didSet {
            objectWillChange.send(self)
        }
    }
    var recordDocumentPath: String? {
        didSet {
            objectWillChange.send(self)
        }
    }
    var recordUrl: URL? {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var canRecord: Bool = false
    
    private var startRecordingAt: Date?

// MARK: record Start
    
    func startRecording() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // The user granted access. Present recording interface.
//                print("acces ok")
                self.canRecord = true
            } else {
//                print("acces pas ok")
                self.canRecord = false
                return
                // Present message to user indicating that recording
                // can't be performed until they change their preference
                // under Settings -> Privacy -> Microphone
            }
        }
        if self.canRecord == true {
            let recordingSession = AVAudioSession.sharedInstance()
            do {
                print(recordingSession.category.rawValue)
                try recordingSession.setCategory(.soloAmbient, mode: .default, options: [])
                try recordingSession.setActive(true)
            } catch {
                print("Failed to set up recording session")
            }
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            self.recordUrl = documentPath.appendingPathComponent("memo-\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            do {
//                WKInterfaceDevice.current().play(.start)
                audioRecorder = try AVAudioRecorder(url: self.recordUrl!, settings: settings)
                audioRecorder.record()
                isRecording = true
                startRecordingAt = Date()
                WKInterfaceDevice.current().play(.start)
            } catch {
                print("Could not start recording")
            }
        }
    }
    
    // MARK: record Stop
    
    func stopRecording() {
        if self.canRecord {
            audioRecorder.stop()
            WKInterfaceDevice.current().play(.stop)
            isRecording = false
            if let url = self.recordUrl {
                print(url)
                self.currentRecording = Recording(fileURL: url, createdFrom: startRecordingAt ?? Date(), createdAt: Date(), fileName: nil, dowloadURL: nil)
            }
        } else {print("pas de permission")}
    }
    func removeCurrentRecording() {
        if let rec = self.currentRecording {
            self.removeRecordingFile(rec: rec)
            self.currentRecording = nil
        }
    }
    func removeRecordingFile(rec: Recording) {
        do {
            try FileManager.default.removeItem(at: rec.fileURL)
        } catch {
            print("Could not remove recording")
        }
    }
    func getCreationDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
}
//class Utils {
//  class func dateFormatter(_ date: Date, _ format: String) -> String {
//    let dateformat = DateFormatter()
//    dateformat.dateFormat = format
//    return dateformat.string(from: date)
//  }
//}
