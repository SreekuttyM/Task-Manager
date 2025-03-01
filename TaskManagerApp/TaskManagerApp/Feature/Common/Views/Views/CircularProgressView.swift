//
//  CircularProgressView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct CircularProgressView: View {
    let color: Color
    let progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.1)
                .foregroundStyle(color)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundStyle(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}

struct SliderView: View {
    @Binding var progress: CGFloat
    let title: String
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessible(.text(label: "SliderText"))
            Slider(value: $progress, in: 0...1.0, minimumValueLabel: Text("0"), maximumValueLabel: Text("100%")) {}
                .accessibilityIdentifier("Slider")

        }
    }
}

#Preview {
    CircularProgressView(color: .red, progress: 0.3)
}
