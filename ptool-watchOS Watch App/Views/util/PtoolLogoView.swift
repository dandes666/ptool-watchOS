//
//  PtoolLogoView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-29.
//

import SwiftUI

struct PtoolLogoView: View {
    var imageWidth:CGFloat
    var imageHeight:CGFloat
    
    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .frame(width: imageWidth, height: imageHeight, alignment: .center)
                
            Text(NSLocalizedString("Guardian", comment: ""))
        }
    }
}

struct PtoolLogoView_Previews: PreviewProvider {
    static var previews: some View {
        PtoolLogoView(imageWidth: 40, imageHeight: 40)
    }
}
