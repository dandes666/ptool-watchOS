//
//  RadarView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-23.
//

import SwiftUI

struct RadarView: View {
    let width: Double
    let height: Double
    @State private var isLoading = false
    var body: some View {
        VStack {
                Image("Radar")
                .resizable()
                .frame(width: width, height: width, alignment: .center)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//                .animation(.easeInOut(duration: 1), value: self.isLoading)
//                .animation(Animation.default.repeatForever(autoreverses: false), value: self.isLoading)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: self.isLoading)
                .onAppear() {
                    self.isLoading = true
                }
        }
        .frame(width: width, height: width, alignment: .center)
    }
}

struct RadarView_Previews: PreviewProvider {
    static var previews: some View {
        RadarView(width: 60, height: 60)
    }
}
