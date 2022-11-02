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
    var title: String
    var body: some View {
        
        VStack {
            
            
            ZStack {
                GeometryReader { (geometry: GeometryProxy) in
                    Image("Logo")
                        .resizable()
//                        .frame(width: 90, height: 90, alignment: .trailing)
                        .frame(width: getBestSquareSize(geo: geometry) * 0.61, height: getBestSquareSize(geo: geometry) * 0.61)
                        .position(x: geometry.size.width * 0.5,y: geometry.size.height * 0.5)
                    //                        .frame(alignment: .center)
                    //                        .frame(width: 90, height: 90, alignment: .center)
                }
                ActivityIndicator()
                    .onAppear() {
                        self.isLoading = true
                    }
                
            }
            //            }.frame(alignment: .center)
            Text("\(title)...")
                .font(.subheadline)
                .lineLimit(2)
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

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack {
            LoadingView(title: "Loading asdf sdu long text")
//        }
    }
}
