//
//  ShaderDesignLangV1Sample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 02.06.2026.
//

import SwiftUI

struct ShaderDesignLangV1Sample: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        ShaderDesignLangV1ShapePreview(title: "Square", shape: .square)
        ShaderDesignLangV1ShapePreview(title: "Circle", shape: .circle)
        ShaderDesignLangV1ShapePreview(title: "Triangle", shape: .triangle)
      }
      .padding()
    }
  }
}

private enum ShaderDesignLangV1Shape: Float {
  case square = 0.0
  case circle = 1.0
  case triangle = 2.0
}

private struct ShaderDesignLangV1ShapePreview: View {
  let title: String
  let shape: ShaderDesignLangV1Shape
  @State private var start = Date()

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.headline)

      TimelineView(.animation) { context in
        let time = context.date.timeIntervalSince(start)

        Rectangle()
          .fill(.white)
          .visualEffect { content, proxy in
            content.colorEffect(
              ShaderLibrary.shaderDesignLangV1(
                .float2(proxy.size),
                .float(Float(time)),
                .float(shape.rawValue)
              )
            )
          }
          .frame(maxWidth: .infinity)
          .frame(height: 200)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  ShaderDesignLangV1Sample()
}
