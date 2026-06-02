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
