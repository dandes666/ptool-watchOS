//
//  PtoolLogoView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct PtoolLogoView: View {
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
            Text("Guardian")
        }
    }
}

struct PtoolLogoView_Previews: PreviewProvider {
    static var previews: some View {
        PtoolLogoView()
    }
}
