//
//  CompleteView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-23.
//

import SwiftUI

struct CompleteView: View {
    @EnvironmentObject var db: AppManager
    let width: Double
    let height: Double
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .font(Font.title3)
                
            Spacer()
            Image(NSLocalizedString("image-logo-complete", comment: ""))
                .resizable()
                .frame(width: width, height: height, alignment: .center)
        }
        .navigationTitle("Retour")
//        .onDisappear() {
//            db.currentTaskStatus = .none
//            db.removeCurrentRecording()
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action : {
//            db.currentTaskStatus = .none
//            db.removeCurrentRecording()
//        }){
//            Image(systemName: "arrow.left")
//        })
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView(width: 130, height: 130, title: "Transfert")
    }
}
