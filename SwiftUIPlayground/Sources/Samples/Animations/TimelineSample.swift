//
//  TimelineSample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 31.05.2026.
//

import SwiftUI

struct TimelineSample: View {
    var body: some View {
        VStack(spacing: 32) {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                Text(context.date, format: .dateTime.hour().minute().second())
                    .monospaced()
            }

            TimelineView(.animation) { context in
                let time = context.date.timeIntervalSinceReferenceDate
                let hue = (sin(time * 0.2) + 1) / 2
                Color(hue: hue, saturation: 0.7, brightness: 0.9)
            }
            .clipShape(.capsule)
            .frame(width: 250, height: 100)

            TimelineView(.animation) { context in
                let format: Date.FormatStyle =
                context.cadence == .live
                ? .dateTime.hour().minute().second().secondFraction(.fractional(3))
                : .dateTime.hour().minute().second()

                Text(context.date, format: format)
                    .monospacedDigit()
            }
        }
    }
}

#Preview {
    TimelineSample()
}
