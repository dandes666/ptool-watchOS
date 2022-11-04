//
//  PlaybackControlButton.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-31.
//

import SwiftUI

struct PlaybackControlButton: View {
    var systemName: String = "play.circle.fill"
    var fontSize: CGFloat = 64
    var color: Color = .white
    var action: () -> Void
    var progress: CGFloat? = nil
    var progressColor: Color = .white
    var disabled: Bool = false
    @State private var isShow = true
    
    var body: some View {
        ZStack {
            if let progress = self.progress {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.4)
                    .foregroundColor(progressColor)
                    .padding()
                    .frame(width: fontSize, height: fontSize)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 8.0)))
                    .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(progressColor)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: isShow)
                    .padding()
                    .frame(width: fontSize, height: fontSize)
//                    .withAnimation(.linear, {})
            }
//                .font(.system(size: fontSize))
            Button {
                action()
            } label: {
                Image(systemName: systemName)
                    .font(.system(size: self.progress == nil ? fontSize : fontSize * 0.65 ))
                    .foregroundColor(color)
            }
            .disabled(disabled)
            .buttonStyle(.plain)
            .padding()
            .font(.system(size: fontSize))
        }
    }
}

struct PlaybackControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControlButton(action: {}, progress: 0.75)
    }
}
