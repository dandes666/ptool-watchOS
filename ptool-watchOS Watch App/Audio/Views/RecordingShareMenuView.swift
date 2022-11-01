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
                switch db.currentTaskStatus {
                case .none:
                    
                    Button(NSLocalizedString("Me rappeler a mon retour au bureau", comment: "")) {
                        print("Me rappeler a mon retour au bureau")
                        db.createMemoOfficeNotification(rec: rec)
                        let memoVocal = MemoVocal(context: moc)
                        
                        memoVocal.id = rec.id
                        memoVocal.active = true
                        memoVocal.url = rec.fileURL
                        memoVocal.officeId = db.userInfo.officeSelected
                        memoVocal.routeId = db.userInfo.routeSelected
                        memoVocal.userId = db.userInfo.userId
                        memoVocal.adviseAt = nil
                        memoVocal.downloadURL = nil
                        memoVocal.createdAt = rec.createdAt
                        memoVocal.createdFrom = rec.createdFrom
                        memoVocal.type = "OFFICE-REMINDER"
                        try? moc.save()
                        db.memoArray += [Memo(id: rec.id, type: MemoType.officeReminder,officeId: db.userInfo.officeSelected, routeId: db.userInfo.routeSelected, fileURL: rec.fileURL, downloadURL: nil, createdAt: rec.createdAt, createdFrom: rec.createdFrom, adviseAt: nil, active: true)]
                        audioRecorder.currentRecording = nil
                        router.reset()
                        router.path.append(MasterRoute.tool)
                        router.path.append(ToolRoute.memoList)
                        print(rec.fileURL)
                    }
                    .lineLimit(3)
                    .padding(1)
                    Button(NSLocalizedString("Envoyer a mon superviseur", comment: "")) {
                        print("Envoi memo au superviseur")
                        db.saveMemoToFirestore(rec: rec, to: "3")
                    }
                    .lineLimit(3)
                    .padding(2)
                    Button(NSLocalizedString("Envoyer au comite mixte", comment: "")) {
                        print("Envoi memo au comite mixte")
                        db.saveMemoToFirestore(rec: rec, to: "mixcomite")
                    }
                    .lineLimit(3)
                    .padding(2)
                    //                    Button("Envoyer au Club Social") {
                    //                        print("Envoi memo au Club Social")
                    //                        db.saveMemoToFirestore(rec: rec, to: "csocial")
                    //                    }
                    //                        .lineLimit(3)
                    //                        .padding(2)
                case .error:
//                        Text("Erreur")
                    ErrorView(width: 100, height: 100, title: NSLocalizedString("Error", comment: ""), desc: db.currentTaskMessage)
                case .success:
                    CompleteView(width: 130, height: 130, title: NSLocalizedString("Envoi de memo reussi", comment: "") )
                        .onDisappear() {
                            audioRecorder.removeCurrentRecording()
                            self.router.reset()
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
            db.currentTaskStatus = .none
        }
        
    }
    func goToComplete() {
        self.router.reset()
        self.router.path.append(MasterRoute.complete)
    }
}

struct RecordingShareMenuView_Previews: PreviewProvider {
    static var previews: some View {
        let fileUrl = URL(filePath: "file///Users/davethibeault/Library/Developer/CoreSimulator/Devices/6E6304FF-E3C6-435A-A1E9-D60AB73D216B/data/Containers/Data/Application/8B41AECC-A9AF-44E9-833A-2EEE894966A8/Documents/")
        RecordingShareMenuView(rec: Recording(fileURL: fileUrl,createdFrom: Date(), createdAt: Date(), fileName: "Nom du fichier", dowloadURL: nil)).environmentObject(AppManager())
    }
}
