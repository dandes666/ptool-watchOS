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
    @State private var isLoading: Bool = false
    var body: some View {
//        GeometryReader { (geometry: GeometryProxy) in
            
            VStack {
                Text(title)
                    .font(Font.subheadline)
                    .scaleEffect(isLoading ? 1 : 0.3, anchor: .top)
                    .animation(.linear(duration: 1), value: self.isLoading)
                Spacer()
                //                GeometryReader { (geometry: GeometryProxy) in
                Image(NSLocalizedString("image-logo-error", comment: ""))
                    .resizable()
//                    .frame(width: getBestSquareSize(geo: geometry) * 0.5, height: getBestSquareSize(geo: geometry) * 0.5, alignment: .center)
                    .frame(width: 70, height: 70, alignment: .center)
                    .scaleEffect(isLoading ? 1 : 0.3)
                    .animation(.linear(duration: 1), value: self.isLoading)
                //                }
                
                if let d = desc {
                    Spacer()
                    ScrollView {
                        Text(d)
                            .font(Font.caption2)
                            .foregroundColor(Color.red)
                            .lineLimit(nil)
                            .scaleEffect(isLoading ? 1 : 0.3, anchor: .bottom)
                            .animation(.linear(duration: 1), value: self.isLoading)
                    }
                }
            }
//            .frame(width: getBestSquareSize(geo: geometry), height: getBestSquareSize(geo: geometry), alignment: .center)
//            .position(x: geometry.size.width * 0.5,y: geometry.size.height * 0.5)
//        }

        .onAppear {
            WKInterfaceDevice.current().play(.failure)
            self.isLoading = true
        }
    }
    func getBestSquareSize(geo: GeometryProxy) -> Double {
        if geo.size.width < geo.size.height {
            return geo.size.width
        } else {
            return geo.size.height
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(width: 90, height: 90, title: "Transfert", desc: "Erreur de communication pasidf  asdlkjasdkjlkjkjsd [ askjd paksjdkj asd[kj a sdjlkjpa[  jsadpfkjasdkjf [kljasdfklj pasdkj asdpfkj aspkldjf")
    }
}
