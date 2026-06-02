//
//  ShaderDesignLangV2Sample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 02.06.2026.
//

import SwiftUI

struct ShaderDesignLangV2Sample: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        ShaderDesignLangV2ShapePreview(title: "Square", shape: .square)
        ShaderDesignLangV2ShapePreview(title: "Circle", shape: .circle)
        ShaderDesignLangV2ShapePreview(title: "Triangle", shape: .triangle)
      }
      .padding()
    }
  }
}

private enum ShaderDesignLangV2Shape: Float {
  case square = 0.0
  case circle = 1.0
  case triangle = 2.0
}

private struct ShaderDesignLangV2ShapePreview: View {
  let title: String
  let shape: ShaderDesignLangV2Shape

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.headline)

      Rectangle()
        .fill(.white)
        .visualEffect { content, proxy in
          content.colorEffect(
            ShaderLibrary.shaderDesignLangV2(
              .float2(proxy.size),
              .float(0),
              .float(shape.rawValue)
            )
          )
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  ShaderDesignLangV2Sample()
}
