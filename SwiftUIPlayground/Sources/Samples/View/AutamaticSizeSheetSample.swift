//
//  AutamaticSizeSheetSample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 31.05.2026.
//

import SwiftUI

struct AutamaticSizeSheetSample: View {
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Open Sheet")
        }
        .sheet(isPresented: $isPresented) {
            Text("👻")
                .font(.system(size: 64))
                .ignoresSafeArea()
                .presentationDetents(.sizeToFit)
        }

    }
}

enum SizeToFitPresentationDetent {
    case sizeToFit
}

struct SizeToFitModifier: ViewModifier {

    let additional: Set<PresentationDetent>

    @State private var contentHeight = 0.0

    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGFloat.self) {
                $0.size.height
            } action: { height in
                contentHeight = height
            }
            .presentationDetents(Set([
                .height(contentHeight)
            ]).union(additional))
    }
}

extension View {

    func presentationDetents(
        _ detent: SizeToFitPresentationDetent,
        additional: Set<PresentationDetent> = []
    ) -> some View {
        modifier(SizeToFitModifier(additional: additional))
    }
}

#Preview {
    AutamaticSizeSheetSample()
}
