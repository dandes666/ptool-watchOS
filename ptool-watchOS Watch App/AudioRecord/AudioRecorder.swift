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

class AudioRecorder: NSObject,ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()
    var recording = false {
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
    var canRecord: Bool = false
//    var isRecorded: Bool = false {
//        didSet {
//            objectWillChange.send(self)
//        }
//    }
    
    override init() {
        super.init()
        fetchRecordings()
    }
    func isRecorded() -> Bool {
        if recordUrl != nil {
            return true
        } else {
            return false
        }
    }
    func startRecording() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // The user granted access. Present recording interface.
                print("acces ok")
                self.canRecord = true
            } else {
                print("acces pas ok")
                self.canRecord = false
                return
                // Present message to user indicating that recording
                // can't be performed until they change their preference
                // under Settings -> Privacy -> Microphone
            }
        }
        if self.canRecord == true {
            print("trace startRecording")
            let recordingSession = AVAudioSession.sharedInstance()
            do {
                print(recordingSession.category.rawValue)
                try recordingSession.setCategory(.soloAmbient, mode: .default, options: [])
                print("trace startRecording apres setCategory")
                try recordingSession.setActive(true)
                print("trace startRecording apres setActive")
            } catch {
                print("Failed to set up recording session")
            }
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            self.recordDocumentPath = documentPath
            //        let audioFilename = documentPath.appendingPathComponent("\(Utils.dateFormatter(Date(), "dd-MM-YY_'at'_HH:mm:ss"))")
            print("trace --> \(documentPath)")
//            let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
            let audioFilename = documentPath.appendingPathComponent("memo.m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            self.recordUrl = audioFilename
            do {
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.record()
                recording = true
            } catch {
                print("Could not start recording")
            }
        }
    }
    func stopRecording() {
        if self.canRecord {
            audioRecorder.stop()
            recording = false
            fetchRecordings()
        } else {print("pas de permission")}
    }
    func playBack() {
        print("trace playBack")
        if let url = self.recordUrl {
            print("trace Start playBack url :")
            print(url)
            var player: AVAudioPlayer!
            print("trace playSound")
            let startAccess = url.startAccessingSecurityScopedResource()
            print("trace startAccess = \(startAccess)")
            do {
                // Set up the AVAudioSession configuration
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        //        try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
        //        print("trace apres cat =")
        //        print(AVAudioSession.sharedInstance().category)
                print("trace playBack apres setCategory")
                try AVAudioSession.sharedInstance().setActive(true)
                print("trace playBack set active")
                // Keep an instance of AVAudioPlayer at the UIViewController level
        //        player.delegate = self
                let data = try! Data(contentsOf: url)
                print("trace playBack apres Data")
                print(data.count)
//                if let data = Dat
//                player = try! AVAudioPlayer(contentsOf: url)
//                let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                let audioFilename = documentPath.appendingPathComponent("memo.m4a")
//                let testurl = try URL(string: url)
                player = try! AVAudioPlayer(contentsOf: url)
//                player = try! AVAudioPlayer(data: data, fileTypeHint: AVFileType.m4a.rawValue)

                print("trace playBack before play")
                player.prepareToPlay()
                player.volume = 10
                player.play()
            } catch let error {
                print("trace playBack erreur playSound")
                print(error.localizedDescription)
                  
            }
            url.stopAccessingSecurityScopedResource()
            print("trace playBack stopAccess")
        }
    }
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio), fileName: "test")
            recordings.append(recording)
        }
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
        objectWillChange.send(self)
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
