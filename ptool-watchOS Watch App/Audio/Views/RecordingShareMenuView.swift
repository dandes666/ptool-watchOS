//
//  RecordingShareMenuView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-17.
//

import SwiftUI

struct RecordingShareMenuView: View {
    let rec: Recording
    @Environment(\.managedObjectContext) var moc
    
    
    @EnvironmentObject var db: AppManager
    @EnvironmentObject var router: Router
    @EnvironmentObject var audioRecorder: AudioRecorder
    
    var body: some View {
        ScrollView{
            VStack {
                switch db.currentTask.status {
                case .none:
                    
                    // MARK: create office reminder
                    
                    Button(NSLocalizedString("Me rappeler a mon retour au bureau", comment: "")) {
                        
                        db.currentTask.message = NSLocalizedString("Me rappeler a mon retour au bureau", comment: "")
                        saveNewMemo(type: .officeReminder, downloadURL: nil)
                    }
                    .lineLimit(3)
                    .padding(.bottom, 7)
                    
                    // MARK: send memo to superviseur
                    
                    Button(NSLocalizedString("Envoyer a mon superviseur", comment: "")) {

                        db.saveMemoToFirestore(rec: rec, to: "3") { (url, error) in
                            if let err = error {
                                db.currentTask.status = .error
                                db.currentTask.error = err
                                db.currentTask.message = err.localizedDescription
                                return
                            } else {
                                db.currentTask.message = NSLocalizedString("Envoyer a mon superviseur", comment: "")
                                self.saveNewMemo(type: .messToSupervisor, downloadURL: url)
                            }
                        }
                    }
                    .lineLimit(3)
                    .padding(.bottom, 7)
                    
                    // MARK: send memo to comite mixte
                    
                    Button(NSLocalizedString("Envoyer au comite mixte", comment: "")) {
                        db.saveMemoToFirestore(rec: rec, to: "mixcomite") { (url, error) in
                            if let err = error {
                                db.currentTask.error = err
                                db.currentTask.message = err.localizedDescription
                                db.currentTask.status = .error
                                return
                            } else {
                                db.currentTask.message = NSLocalizedString("Envoyer au comite mixte", comment: "")
                                self.saveNewMemo(type: .messToComiteMixte, downloadURL: url)
                            }
                        }
                    }
                    .lineLimit(3)
                    
                    // MARK: send memo to Club Social
                    
                    //                    Button("Envoyer au Club Social") {
                    //                        print("Envoi memo au Club Social")
                    //                        db.saveMemoToFirestore(rec: rec, to: "csocial")
                    //                    }
                    //                        .lineLimit(3)
                    //                        .padding(2)
                    
                    
                case .error:
                    
                    // MARK: error task
                    
                    ErrorView(width: 100, height: 100, title: NSLocalizedString("Error", comment: ""), desc: db.currentTask.message)
                        .onDisappear() {
                            db.currentTask.reset()
                        }
                case .success:
                    
                    // MARK: success task
                    
                    CompleteView(width: 130, height: 130, title: db.currentTask.message ?? "")
                        .onDisappear() {
                            self.router.reset()
                            self.router.path.append(MasterRoute.tool)
                            self.router.path.append(MemoListParam(mode: .standart))
                            audioRecorder.currentRecording = nil
                        }
                case .done:
                    Text("Done")
                case .pause:
                    Text("Pause")
                case .inProgress:
                    LoadingView(title: "transmission en cours")
                }
            }
        }
        .navigationTitle(NSLocalizedString("memo", comment: ""))
        .onDisappear() {
            db.currentTask.status = .none
        }
        
    }
    func saveNewMemo(type: MemoType, downloadURL: URL?) {
        let memoVocal = MemoVocal(context: moc)
        
        memoVocal.id = rec.id
        memoVocal.active = true
        memoVocal.url = rec.fileURL
        memoVocal.officeId = db.userInfo.officeSelected
        memoVocal.routeId = db.userInfo.routeSelected
        memoVocal.userId = db.userInfo.userId
        memoVocal.adviseAt = nil
        memoVocal.downloadURL = downloadURL
        memoVocal.createdAt = rec.createdAt
        memoVocal.createdFrom = rec.createdFrom
        memoVocal.type = db.getMemoTypeString(memoType: type)
        try? moc.save()

    }
}

struct RecordingShareMenuView_Previews: PreviewProvider {
    static var previews: some View {
        let fileUrl = URL(filePath: "file///Users/davethibeault/Library/Developer/CoreSimulator/Devices/6E6304FF-E3C6-435A-A1E9-D60AB73D216B/data/Containers/Data/Application/8B41AECC-A9AF-44E9-833A-2EEE894966A8/Documents/")
        RecordingShareMenuView(rec: Recording(fileURL: fileUrl,createdFrom: Date(), createdAt: Date(), fileName: "Nom du fichier", dowloadURL: nil)).environmentObject(AppManager())
    }
}
