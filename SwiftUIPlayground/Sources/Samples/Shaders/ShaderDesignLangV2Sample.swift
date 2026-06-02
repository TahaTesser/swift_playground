//
//  ShaderDesignLangV2Sample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 02.06.2026.
//

import SwiftUI

struct ShaderDesignLangV2Sample: View {
  private let cardCount = 16
  private let pagePadding: CGFloat = 64
  private let cardAspectRatio: CGFloat = 5.0 / 7.0
  private let controlHeight: CGFloat = 44
  private let cardButtonSpacing: CGFloat = 14
  @State private var effectProgress = Array(repeating: 1.0, count: 16)

  var body: some View {
    GeometryReader { proxy in
      let cardSize = playingCardSize(in: proxy.size)

      ScrollView(.horizontal) {
        HStack(spacing: 28) {
          ForEach(0..<cardCount, id: \.self) { index in
            VStack(spacing: cardButtonSpacing) {
              ShaderDesignLangV2PlayingCard(
                effect: cardEffect(for: index),
                progress: effectProgress[index]
              )
              .frame(width: cardSize.width, height: cardSize.height)

              Button {
                playEffect(at: index)
              } label: {
                Image(systemName: "play.fill")
                  .font(.system(size: 15, weight: .semibold))
                  .frame(width: 36, height: 36)
              }
              .buttonStyle(.borderedProminent)
              .buttonBorderShape(.circle)
              .frame(height: controlHeight)
            }
            .frame(width: cardSize.width)
          }
        }
        .padding(pagePadding)
        .frame(minHeight: proxy.size.height)
      }
      .scrollIndicators(.hidden)
      .background(Color(.systemBackground))
    }
  }

  private func playingCardSize(in containerSize: CGSize) -> CGSize {
    let availableWidth = max(containerSize.width - pagePadding * 2, 1)
    let availableHeight = max(containerSize.height - pagePadding * 2 - controlHeight - cardButtonSpacing, 1)
    let widthFromHeight = availableHeight * cardAspectRatio
    let cardWidth = min(availableWidth, widthFromHeight)

    return CGSize(width: cardWidth, height: cardWidth / cardAspectRatio)
  }

  private func cardEffect(for index: Int) -> ShaderDesignLangV2CardEffect {
    switch index {
    case 0:
      return .frosted
    case 1:
      return .cracked
    default:
      return .blank
    }
  }

  private func playEffect(at index: Int) {
    guard effectProgress.indices.contains(index) else { return }

    var resetTransaction = Transaction()
    resetTransaction.disablesAnimations = true
    withTransaction(resetTransaction) {
      effectProgress[index] = 0
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
      withAnimation(cardEffect(for: index).animation) {
        effectProgress[index] = 1
      }
    }
  }
}

private enum ShaderDesignLangV2CardEffect {
  case blank
  case frosted
  case cracked

  var animation: Animation {
    switch self {
    case .frosted:
      return .easeInOut(duration: 1.65)
    case .cracked:
      return .easeInOut(duration: 0.86)
    case .blank:
      return .easeOut(duration: 0.35)
    }
  }
}

private struct ShaderDesignLangV2PlayingCard: View {
  let effect: ShaderDesignLangV2CardEffect
  let progress: CGFloat
  private let cornerRadius: CGFloat = 28
  private let cardBackground = Color(red: 30 / 255, green: 32 / 255, blue: 30 / 255)

  var body: some View {
    cardSurface
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
      .compositingGroup()
      .shadow(color: .black.opacity(0.18), radius: 30, x: 0, y: 18)
  }

  @ViewBuilder
  private var cardSurface: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .fill(cardBackground)

      ShaderDesignLangV2CardEmoji()
        .padding(36)

      if effect == .frosted {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
          .fill(.white)
          .visualEffect { content, proxy in
            content.colorEffect(
              ShaderLibrary.shaderDesignLangV2FrostedCard(
                .float2(proxy.size),
                .float(0)
              )
            )
          }
          .mask {
            ShaderDesignLangV2FrostMask(progress: progress)
          }
          .opacity(0.64)
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
      }

      if effect == .cracked {
        ShaderDesignLangV2CrackOverlay(progress: progress)
          .padding(28)
      }
    }
  }
}

private struct ShaderDesignLangV2FrostMask: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      edgeGradient(start: .top, end: .bottom)
      edgeGradient(start: .bottom, end: .top)
      edgeGradient(start: .leading, end: .trailing)
      edgeGradient(start: .trailing, end: .leading)
    }
    .blur(radius: 8)
    .animation(.easeInOut(duration: 1.65), value: progress)
  }

  private func edgeGradient(start: UnitPoint, end: UnitPoint) -> some View {
    let reach = max(min(progress, 1), 0.001) * 0.50

    return LinearGradient(
      stops: [
        .init(color: .white, location: 0.0),
        .init(color: .white.opacity(0.84), location: reach * 0.22),
        .init(color: .white.opacity(0.38), location: reach * 0.58),
        .init(color: .clear, location: reach),
        .init(color: .clear, location: 1.0)
      ],
      startPoint: start,
      endPoint: end
    )
  }
}

private struct ShaderDesignLangV2CrackOverlay: View {
  let progress: CGFloat

  var body: some View {
    GeometryReader { proxy in
      let scale = min(proxy.size.width, proxy.size.height)

      ZStack {
        ShaderDesignLangV2CrackShape()
          .trim(from: 0, to: progress)
          .stroke(
            Color(red: 0.88, green: 0.98, blue: 1.0).opacity(0.82),
            style: StrokeStyle(lineWidth: scale * 0.0052, lineCap: .round, lineJoin: .round)
          )
      }
      .blendMode(.screen)
      .opacity(progress)
    }
    .allowsHitTesting(false)
  }
}

private struct ShaderDesignLangV2CrackShape: Shape {
  func path(in rect: CGRect) -> Path {
    func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
      CGPoint(x: rect.minX + rect.width * x, y: rect.minY + rect.height * y)
    }

    var path = Path()

    path.move(to: point(-0.04, 0.06))
    path.addQuadCurve(to: point(0.18, 0.17), control: point(0.08, 0.10))
    path.addQuadCurve(to: point(0.34, 0.30), control: point(0.25, 0.24))
    path.addQuadCurve(to: point(0.48, 0.45), control: point(0.40, 0.36))
    path.addQuadCurve(to: point(0.60, 0.60), control: point(0.55, 0.52))
    path.addQuadCurve(to: point(0.75, 0.78), control: point(0.67, 0.70))
    path.addQuadCurve(to: point(1.04, 1.02), control: point(0.90, 0.92))

    path.move(to: point(0.34, 0.30))
    path.addQuadCurve(to: point(0.18, 0.44), control: point(0.27, 0.36))
    path.addQuadCurve(to: point(-0.02, 0.64), control: point(0.08, 0.54))

    path.move(to: point(0.48, 0.45))
    path.addQuadCurve(to: point(0.72, 0.32), control: point(0.60, 0.36))
    path.addQuadCurve(to: point(1.02, 0.20), control: point(0.88, 0.24))

    path.move(to: point(0.60, 0.60))
    path.addQuadCurve(to: point(0.42, 0.74), control: point(0.51, 0.67))
    path.addQuadCurve(to: point(0.28, 1.03), control: point(0.34, 0.88))

    path.move(to: point(0.67, 0.70))
    path.addQuadCurve(to: point(0.84, 0.64), control: point(0.76, 0.66))
    path.addQuadCurve(to: point(1.02, 0.60), control: point(0.93, 0.62))

    path.move(to: point(0.54, 0.52))
    path.addQuadCurve(to: point(0.50, 0.78), control: point(0.50, 0.64))
    path.addQuadCurve(to: point(0.48, 1.02), control: point(0.50, 0.90))

    path.move(to: point(-0.03, 0.86))
    path.addQuadCurve(to: point(0.18, 0.74), control: point(0.07, 0.79))
    path.addQuadCurve(to: point(0.34, 0.70), control: point(0.26, 0.71))

    path.move(to: point(0.66, -0.02))
    path.addQuadCurve(to: point(0.66, 0.20), control: point(0.68, 0.10))
    path.addQuadCurve(to: point(0.70, 0.38), control: point(0.66, 0.30))

    path.move(to: point(0.03, 0.28))
    path.addQuadCurve(to: point(0.20, 0.34), control: point(0.11, 0.30))
    path.addQuadCurve(to: point(0.31, 0.42), control: point(0.27, 0.38))

    return path
  }
}

private struct ShaderDesignLangV2CardEmoji: View {
  private let emoji = "🙂"

  var body: some View {
    GeometryReader { proxy in
      let size = min(proxy.size.width, proxy.size.height) * 0.58

      Text(emoji)
        .font(.system(size: size))
        .minimumScaleFactor(0.5)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .allowsHitTesting(false)
  }
}

#Preview {
  ShaderDesignLangV2Sample()
}
