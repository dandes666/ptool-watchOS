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
    @State private var isLoading = false
    var body: some View {
        
        VStack {
            Spacer()
//            GeometryReader { (geometry: GeometryProxy) in
                //                Spacer()
                Image(NSLocalizedString("image-logo-complete", comment: ""))
                
                    .resizable()
//                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6, alignment: .center)
                    .frame(width: 90, height: 90, alignment: .center)
                    .rotationEffect(Angle(degrees: isLoading ? 0 : 50))
                    .scaleEffect(isLoading ? 1 : 0.3)
                    .animation(.easeOut(duration: 0.5), value: self.isLoading)
                //                                .animation(.linear(duration: 0.5).repeatForever(), value: self.isLoading)
//                    .position(x: geometry.size.width * 0.5,y: geometry.size.height * 0.5)
//            }
            Spacer()
            Text(title)
                .font(.subheadline)
                .lineLimit(2)
            Spacer()
            
            //            .position(x: geometry.size.width * 0.5,y: geometry.size.height * 0.5)
        }
        .navigationTitle(NSLocalizedString("Retour", comment: ""))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            withAnimation {
                isLoading = true
            }
            WKInterfaceDevice.current().play(.success)
        }
//        .onDisappear() {
//            db.currentTask.status = .none
//            db.removeCurrentRecording()
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action : {
//            db.currentTask.status = .none
//            db.removeCurrentRecording()
//        }){
//            Image(systemName: "arrow.left")
//        })
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CompleteView(width: 130, height: 130, title: "Transfert")
        }
    }
}
