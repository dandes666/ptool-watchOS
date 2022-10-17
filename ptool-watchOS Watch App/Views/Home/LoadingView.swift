//
//  LoadingView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-23.
//

import SwiftUI

struct LoadingView: View {
//    @EnvironmentObject var db: AppManager
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            ZStack {
//                PtoolLogoView(imageWidth: 50, imageHeight: 50)
//                    .navigationTitle("Chargement...")
                Image("Logo")
                    .resizable()
                    .frame(width: 110, height: 110, alignment: .center)
                Image("LoadingLoopIcon2")
//                Image("Radar")
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//                    .animation(Animation.easeIn(duration: 1), value: self.isLoading)
                    .animation(Animation.default.repeatForever(autoreverses: false), value: self.isLoading)
//                        .animation(Animation.default.repeatForever(autoreverses: false))
                    .onAppear() {
                        self.isLoading = true
                    }
                    .navigationTitle("Chargement...")

            }

        }
    }

}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
