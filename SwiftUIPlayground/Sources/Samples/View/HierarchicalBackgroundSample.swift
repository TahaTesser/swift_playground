//
//  HierarchicalBackgroundSample.swift
//  SwiftUIPlayground
//
//  Created by Taha Tesser on 31.05.2026.
//

import SwiftUI

struct HierarchicalBackgroundSample: View {
    var body: some View {
        HStack {
            Image(systemName: "star")
                .padding()
                .background(.tint.quaternary)
            Image(systemName: "star")
                .padding()
                .background(.tint.quinary)
            Image(systemName: "star")
                .padding()
                .background(.tint.tertiary)
            Image(systemName: "star")
                .padding()
                .background(.tint.secondary)
        }
        HStack {
            Image(systemName: "star")
                .padding()
                .background(.green.quaternary)
            Image(systemName: "star")
                .padding()
                .background(.green.quinary)
            Image(systemName: "star")
                .padding()
                .background(.green.tertiary)
            Image(systemName: "star")
                .padding()
                .background(.green.secondary)
        }
    }
}

#Preview {
    HierarchicalBackgroundSample()
}
