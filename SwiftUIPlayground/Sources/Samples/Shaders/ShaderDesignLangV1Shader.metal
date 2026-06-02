//
//  ShaderDesignLangV1Shader.metal
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 02.06.2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

float2 squareCanvasUV(float2 position, float2 size) {
    float shortestSide = min(size.x, size.y);
    return (position - size * 0.5) / shortestSide + 0.5;
}

half3 backdropColor() {
    return half3(0.94, 0.95, 0.97);
}

half3 stylePalette(float shapeKind) {
    if (shapeKind < 0.5) {
        return half3(0.10, 0.88, 0.98);
    }

    if (shapeKind < 1.5) {
        return half3(1.00, 0.10, 0.62);
    }

    return half3(1.00, 0.74, 0.12);
}

float squareMask(float2 uv) {
    float2 p = abs(uv - 0.5);
    float d = max(p.x, p.y);
    return smoothstep(0.356, 0.342, d);
}

float circleMask(float2 uv) {
    float d = length(uv - 0.5);
    return smoothstep(0.360, 0.342, d);
}

float triangleMask(float2 uv) {
    float2 a = float2(0.5, 0.16);
    float2 b = float2(0.15, 0.82);
    float2 c = float2(0.85, 0.82);

    float2 ab = b - a;
    float2 bc = c - b;
    float2 ca = a - c;
    float2 ap = uv - a;
    float2 bp = uv - b;
    float2 cp = uv - c;

    float e0 = ab.x * ap.y - ab.y * ap.x;
    float e1 = bc.x * bp.y - bc.y * bp.x;
    float e2 = ca.x * cp.y - ca.y * cp.x;
    float inside = -max(max(e0, e1), e2);

    return smoothstep(-0.006, 0.012, inside);
}

float shapeMask(float2 uv, float shapeKind) {
    if (shapeKind < 0.5) {
        return squareMask(uv);
    }

    if (shapeKind < 1.5) {
        return circleMask(uv);
    }

    return triangleMask(uv);
}

float contourMask(float mask) {
    return smoothstep(0.48, 0.58, mask) - smoothstep(0.80, 0.90, mask);
}

half3 neonFill(float2 uv, half3 baseColor, float shapeKind) {
    float light = smoothstep(0.10, 1.0, 1.0 - uv.y + uv.x * 0.44);
    float lowerShadow = smoothstep(0.10, 0.95, uv.y - uv.x * 0.10);
    float neonShift = smoothstep(0.22, 1.0, uv.x + (1.0 - uv.y) * 0.55);

    half3 hotMagenta = half3(1.0, 0.06, 0.76);
    half3 electricCyan = half3(0.06, 0.88, 1.0);
    half3 warmOrange = half3(1.0, 0.42, 0.10);
    half3 deepInk = half3(0.04, 0.05, 0.12);

    half3 accent = mix(electricCyan, hotMagenta, half(fract(shapeKind * 0.37 + 0.35)));
    accent = mix(accent, warmOrange, half(shapeKind > 1.5 ? 0.45 : 0.0));

    half3 color = mix(baseColor, accent, half(neonShift * 0.42));
    color = mix(color, half3(1.0, 0.94, 0.78), half(light * 0.30));
    color = mix(color, deepInk, half(lowerShadow * 0.34));

    return color;
}

float rimLight(float2 uv, float mask) {
    float edge = contourMask(mask);
    float direction = smoothstep(0.12, 1.0, uv.x + (1.0 - uv.y) * 0.9);
    return edge * direction;
}

[[ stitchable ]]
half4 shaderDesignLangV1(
    float2 position,
    half4 currentColor,
    float2 size,
    float time,
    float shapeKind
) {
    float2 canvasUV = squareCanvasUV(position, size);
    float2 artUV = (canvasUV - 0.5) / 0.82 + 0.5;

    half3 backdrop = backdropColor();
    float mask = shapeMask(artUV, shapeKind);
    float softMask = smoothstep(0.05, 0.95, mask);

    half3 base = stylePalette(shapeKind);
    half3 fill = neonFill(artUV, base, shapeKind);
    half3 color = mix(backdrop, fill, half(softMask));

    float contour = contourMask(mask);
    half3 ink = half3(0.01, 0.015, 0.045);
    color = mix(color, ink, half(contour * 0.78));

    float rim = rimLight(artUV, mask);
    color = mix(color, half3(0.12, 0.95, 1.0), half(rim * 0.62));

    return half4(color, 1.0);
}
