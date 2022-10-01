//
//  LoadingView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-23.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            ZStack {
//                PtoolLogoView(imageWidth: 50, imageHeight: 50)
//                    .navigationTitle("Chargement...")
                Image("Logo")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                Image("LoadingLoopIcon")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.default.repeatForever(autoreverses: false), value: self.isLoading)
//                        .animation(Animation.default.repeatForever(autoreverses: false))
                    .onAppear() {
                        self.isLoading = true
                    }
                    .navigationTitle("Chargement...")
//                Circle()
//                            .trim(from: 0, to: 0.7)
//                            .stroke(Color.green, lineWidth: 5)
//                            .frame(width: 100, height: 100)
//                            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//                            .animation(Animation.default.repeatForever(autoreverses: false))
//                            .onAppear() {
//                                self.isLoading = true
//                            }
//                Text("Chargement...")
                //            Image("Logo")
                //                .resizable()
                //                .frame(width: 60, height: 60, alignment: .center)
                //                .navigationTitle("Chargement...")
            }

        }
    }

}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
