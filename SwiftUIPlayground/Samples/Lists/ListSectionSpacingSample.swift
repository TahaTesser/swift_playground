//
//  ListSectionSpacingSample.swift
//  playground
//
//  Created by Taha Tesser on 09.08.2024.
//

import SwiftUI

struct ListSectionSpacingSample: View {
    var body: some View {
        #if os(macOS)
            Text("List section spacing is not available on macOS")
                .font(.title)
                .padding()
        #else
            TabView {
                Tab {
                    List {
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                    }
                    .listSectionSpacing(.default)
                } label: {
                    Text("Default")
                }
                Tab {
                    List {
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                    }
                    .listSectionSpacing(.compact)
                } label: {
                    Text("Compact")
                }
                Tab {
                    List {
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                        Section {
                            Text("A List Item")
                            Text("A Second List Item")
                            Text("A Third List Item")
                        }
                    }
                    .listSectionSpacing(70)
                } label: {
                    Text("Custom")
                }
            }
        #endif
    }
}

#Preview {
    ListSectionSpacingSample()
}
