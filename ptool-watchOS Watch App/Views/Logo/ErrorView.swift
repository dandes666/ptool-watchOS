//
//  ErrorView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-23.
//

import SwiftUI

struct ErrorView: View {
    let width: Double
    let height: Double
    let title: String
    let desc: String?
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(Font.title3)
                Spacer()
                Image(NSLocalizedString("image-logo-error", comment: ""))
                    .resizable()
                    .frame(width: width, height: height, alignment: .center)
                Spacer()
                if let d = desc {
                    Text(d)
                        .font(Font.caption)
                        .foregroundColor(Color.red)
                        .lineLimit(nil)
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(width: 110, height: 110, title: "Transfert", desc: "Erreur de communication")
    }
}
