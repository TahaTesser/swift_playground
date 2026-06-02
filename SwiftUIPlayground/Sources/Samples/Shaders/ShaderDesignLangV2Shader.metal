//
//  ShaderDesignLangV2Shader.metal
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 02.06.2026.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

float2 shaderDesignLangV2SquareCanvasUV(float2 position, float2 size) {
    float shortestSide = min(size.x, size.y);
    return (position - size * 0.5) / shortestSide + 0.5;
}

float shaderDesignLangV2SquareMask(float2 uv) {
    float2 p = abs(uv - 0.5);
    float d = max(p.x, p.y);
    return smoothstep(0.356, 0.342, d);
}

float shaderDesignLangV2CircleMask(float2 uv) {
    float d = length(uv - 0.5);
    return smoothstep(0.360, 0.342, d);
}

float shaderDesignLangV2TriangleMask(float2 uv) {
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

float shaderDesignLangV2ShapeMask(float2 uv, float shapeKind) {
    if (shapeKind < 0.5) {
        return shaderDesignLangV2SquareMask(uv);
    }

    if (shapeKind < 1.5) {
        return shaderDesignLangV2CircleMask(uv);
    }

    return shaderDesignLangV2TriangleMask(uv);
}

half3 shaderDesignLangV2FlatPalette(float shapeKind) {
    if (shapeKind < 0.5) {
        return half3(1.000, 0.000, 0.780);
    }

    if (shapeKind < 1.5) {
        return half3(0.090, 0.860, 0.920);
    }

    return half3(0.045, 0.035, 0.095);
}

float shaderDesignLangV2Hash(float2 value) {
    return fract(sin(dot(value, float2(127.1, 311.7))) * 43758.5453);
}

float shaderDesignLangV2SoftNoise(float2 uv) {
    float2 cell = floor(uv);
    float2 local = fract(uv);
    float2 blend = local * local * (3.0 - 2.0 * local);

    float a = shaderDesignLangV2Hash(cell);
    float b = shaderDesignLangV2Hash(cell + float2(1.0, 0.0));
    float c = shaderDesignLangV2Hash(cell + float2(0.0, 1.0));
    float d = shaderDesignLangV2Hash(cell + float2(1.0, 1.0));

    return mix(mix(a, b, blend.x), mix(c, d, blend.x), blend.y);
}

float shaderDesignLangV2CardLobe(float2 uv, float2 center, float2 scale) {
    float2 p = (uv - center) * scale;
    return smoothstep(1.0, 0.0, dot(p, p));
}

half4 shaderDesignLangV2FrostedPalette(float2 uv) {
    half3 glassBlue = half3(0.350, 0.780, 0.950);
    half3 neonViolet = half3(0.470, 0.170, 0.820);
    half3 iceWhite = half3(0.880, 0.980, 1.000);
    half3 electricCyan = half3(0.090, 0.860, 0.920);
    half3 neonPink = half3(1.000, 0.000, 0.780);

    float shimmer = shaderDesignLangV2SoftNoise(uv * 18.0 + float2(8.0, 13.0));
    float satin = shaderDesignLangV2SoftNoise(uv * 5.5 + float2(21.0, 4.0));
    float sideCyan = smoothstep(0.0, 1.0, 1.0 - uv.y + uv.x * 0.18);
    float sidePink = smoothstep(0.0, 1.0, uv.y + uv.x * 0.24);

    half3 color = mix(glassBlue, neonViolet, half(uv.y * 0.42 + uv.x * 0.10));
    color = mix(color, electricCyan, half(sideCyan * 0.24));
    color = mix(color, neonPink, half(sidePink * 0.18));
    color = mix(color, iceWhite, half((1.0 - shimmer) * 0.10));
    color += half3(0.020, 0.026, 0.034) * half((satin - 0.5) * 0.18);

    return half4(clamp(color, half3(0.0), half3(1.0)), 1.0);
}

[[ stitchable ]]
half4 shaderDesignLangV2(
    float2 position,
    half4 currentColor,
    float2 size,
    float time,
    float shapeKind
) {
    float2 canvasUV = shaderDesignLangV2SquareCanvasUV(position, size);
    float2 artUV = (canvasUV - 0.5) / 0.82 + 0.5;
    float mask = shaderDesignLangV2ShapeMask(artUV, shapeKind);

    return half4(shaderDesignLangV2FlatPalette(shapeKind), half(mask));
}

[[ stitchable ]]
half4 shaderDesignLangV2FrostedCard(
    float2 position,
    half4 currentColor,
    float2 size,
    float time
) {
    float2 uv = position / size;
    half4 frost = shaderDesignLangV2FrostedPalette(uv);
    return half4(frost.rgb, currentColor.a * frost.a);
}
