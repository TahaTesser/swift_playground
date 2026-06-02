//
//  Samples.swift
//  playground
//
//  Created by Taha Tesser on 08.08.2024.
//

import SwiftUI

public struct SampleItem: Identifiable {
  public let id: String
  public let title: String
  public let destination: AnyView

  public init<V: View>(_ title: String, id: String? = nil, @ViewBuilder destination: () -> V) {
    self.id = id ?? title
    self.title = title
    self.destination = AnyView(destination())
  }
}

public struct SampleSection: Identifiable {
  public let id: String
  public let title: String
  public let samples: [SampleItem]

  public init(id: String? = nil, title: String, samples: [SampleItem]) {
    self.id = id ?? title
    self.title = title
    self.samples = samples
  }
}

@MainActor private let sampleSections: [SampleSection] = [
    SampleSection(
      id: "buttons",
      title: "Buttons",
      samples: [
        // https://developer.apple.com/documentation/swiftui/button
        SampleItem("Button Border Shape", id: "buttons-button-border-shape") {
          ButtonBorderShapeSample()
        }
      ]),
    SampleSection(
      id: "map",
      title: "Map",
      samples: [
        // https://developer.apple.com/documentation/mapkit/map
        SampleItem("MapStyle", id: "map-map-style") { MapStyleSample() }
      ]),
    SampleSection(
      id: "gesture",
      title: "Gesture",
      samples: [
        // https://developer.apple.com/documentation/swiftui/rotategesture
        SampleItem("Rotate Gesture", id: "gesture-rotate-gesture") { RotateGestureSample() }
      ]),
    SampleSection(
      id: "third-party",
      title: "Third party",
      samples: [
        // https://github.com/christianselig/JunoSlider
        SampleItem("JunoUI Slider", id: "third-party-juno-ui-slider") { JunoUISliderSample() }
      ]),
    SampleSection(
      id: "layout-adjustments",
      title: "Layout Adjustments",
      samples: [
        // https://developer.apple.com/documentation/swiftui/view/containerrelativeframe(_:alignment:)
        SampleItem("Container Relative Frame", id: "layout-adjustments-container-relative-frame") {
          ContainerRelativeFrameSample()
        },
        // https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)-6gwby
        SampleItem("safeAreaInset", id: "layout-adjustments-safe-area-inset") {
          SafeAreaInsetSample()
        },
        // https://developer.apple.com/documentation/swiftui/view/alignmentguide(_:computevalue:)-6y3u2
        SampleItem("alignmentGuide", id: "layout-adjustments-alignment-guide") {
          AlignmentGuideSample()
        }
      ]),
    SampleSection(
      id: "drawing-and-graphics",
      title: "Drawing and Graphics",
      samples: [
        // https://developer.apple.com/documentation/swiftui/view/compositinggroup()
        SampleItem("Compsiting Group", id: "drawing-and-graphics-compsiting-group") {
          CompsitingGroupSample()
        },
        // https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:)
        SampleItem("Masking", id: "drawing-and-graphics-masking") { MaskingSample() }
      ]),
    SampleSection(
      id: "shaders",
      title: "Shaders",
      samples: [
        SampleItem("Shape Shader Design Language V1", id: "shaders-shape-design-lang-v1") {
          ShaderDesignLangV1Sample()
        },
        SampleItem("Shape Shader Design Language V2", id: "shaders-shape-design-lang-v2") {
          ShaderDesignLangV2Sample()
        }
      ]),
    SampleSection(
      id: "tables",
      title: "Tables",
      samples: [
        // https://developer.apple.com/documentation/swiftui/table
        SampleItem("Table", id: "tables-table") { TableSample() }
      ]),
    SampleSection(
      id: "text",
      title: "Text",
      samples: [
        // https://developer.apple.com/documentation/swiftui/textrenderer
        SampleItem("Text Renderer", id: "text-text-renderer") { TextRendererSample() },
        // https://developer.apple.com/documentation/swiftui/text/datestyle
        SampleItem("Relative DateStyle", id: "text-relative-date-style") {
          RelativeDateStyleSample()
        },
        // https://developer.apple.com/documentation/swiftui/font
        SampleItem("Typography", id: "text-typography") { TypographySample() },
        // https://developer.apple.com/documentation/swiftui/view/foregroundstyle(_:)
        SampleItem("ForegroundStyle", id: "text-foreground-style") { ForegroundStyleSample() }
      ]),
    SampleSection(
      id: "navigation",
      title: "Navigation",
      samples: [
        // https://developer.apple.com/documentation/swiftui/tabview
        SampleItem("Tab View", id: "navigation-tab-view") { TabViewSample() },
        // https://developer.apple.com/documentation/swiftui/tabviewstyle
        SampleItem("Tab View Style", id: "navigation-tab-view-style") { TabViewStyleSample() }
      ]),
    SampleSection(
      id: "images-async-variable",
      title: "Images",
      samples: [
        // https://developer.apple.com/documentation/swiftui/asyncimage
        SampleItem("Async Image", id: "images-async-variable-async-image") { AsyncImageSample() },
        // https://developer.apple.com/documentation/swiftui/image/init(_:variablevalue:bundle:)
        SampleItem("Images", id: "images-async-variable-variable-value-image") {
          VariableValueSample()
        }
      ]),
    SampleSection(
      id: "view-groupings",
      title: "View Groupings",
      samples: [
        // https://developer.apple.com/documentation/swiftui/form
        SampleItem("Form", id: "view-groupings-form") { FormSample() },
        // https://developer.apple.com/documentation/swiftui/groupbox
        SampleItem("GroupBox", id: "view-groupings-group-box") { GroupBoxSample() },
        // https://developer.apple.com/documentation/swiftui/view/scrollcontentbackground(_:)
        SampleItem("scrollContentBackground", id: "view-groupings-scroll-content-background") {
          ScrollContentBackgroundSample()
        }
      ]),
    SampleSection(
      id: "lists",
      title: "Lists",
      samples: [
        // https://developer.apple.com/documentation/swiftui/disclosuregroup
        SampleItem("Disclosure Group", id: "lists-disclosure-group") { DisclosureGroupSample() },
        // https://developer.apple.com/documentation/swiftui/listsectionspacing
        SampleItem("List Section Spacing", id: "lists-list-section-spacing") {
          ListSectionSpacingSample()
        }
      ]),
    SampleSection(
      id: "slider",
      title: "Slider",
      samples: [
        // https://developer.apple.com/documentation/swiftui/slider
        SampleItem("Slider", id: "slider-slider") { SliderSample() }
      ]),
    SampleSection(
      id: "charts",
      title: "Charts",
      samples: [
        // https://developer.apple.com/documentation/charts/linemark
        SampleItem("LineChart", id: "charts-line-chart") { LineChartSample() }
      ]),
    SampleSection(
      id: "images-avatar",
      title: "Images",
      samples: [
        SampleItem("Circle Avatar", id: "images-avatar-circle-avatar") { CircleAvatarSample() }
      ]),
    SampleSection(
      id: "controls-and-indicators",
      title: "Controls and Indicators",
      samples: [
        SampleItem("Stepper", id: "controls-and-indicators-stepper") { StepperSample() },
        SampleItem("ColorPicker", id: "controls-and-indicators-color-picker") {
          ColorPickerSample()
        },
        SampleItem("ProgressView", id: "controls-and-indicators-progress-view") {
          ProgressViewSample()
        }
      ]),
    SampleSection(
      id: "layout-fundamentals",
      title: "Layout Fundamentals",
      samples: [
        // https://developer.apple.com/documentation/swiftui/viewthatfits
        SampleItem("ViewThatFits", id: "layout-fundamentals-view-that-fits") {
          ViewThatFitsSample()
        }
      ]),
    SampleSection(
      id: "animations",
      title: "Animations",
      samples: [
        // https://developer.apple.com/documentation/swiftui/timelineview
        SampleItem("TimelineView", id: "animations-timeline-view") {
          TimelineSample()
        },
        // https://developer.apple.com/documentation/swiftui/view/
        // matchedgeometryeffect(id:in:properties:anchor:issource:)
        SampleItem("matchedgeometryeffect", id: "animations-matched-geometry-effect") {
          MatchedGeometryEffectSample()
        }
      ]),
    SampleSection(
      id: "custom-layout",
      title: "Custom Layout",
      samples: [
        // https://developer.apple.com/documentation/swiftui/layout
        SampleItem("Layout Protocol", id: "custom-layout-layout-protocol") {
          LayoutProtocolSample()
        }
      ]),
    SampleSection(
      id: "view-fundamentals",
      title: "View Fundamentals",
      samples: [
        // https://developer.apple.com/documentation/swiftui/viewmodifier
        SampleItem("ViewModifier Protocol", id: "view-fundamentals-view-modifier-protocol") {
          ViewModifierProtocolSample()
        }
      ]),
    SampleSection(
      id: "shapes-progress-stroke",
      title: "Shapes",
      samples: [
        SampleItem("Progress Indicator Arc", id: "shapes-progress-stroke-progress-indicator-arc") {
          ProgressIndicatorArcSample()
        },
        SampleItem("Stroke Border", id: "shapes-progress-stroke-stroke-border") {
          StrokeBorderSample()
        },
        SampleItem("Polygon", id: "shapes-progress-stroke-polygon") {
          PolygonSample()
        }
      ]),
    SampleSection(
      id: "view-color-flipper",
      title: "View",
      samples: [
        SampleItem("Color Brightess", id: "view-color-flipper-color-brightness") {
          ColorBrightnessSample()
        },
        SampleItem("Flipper Animation", id: "view-color-flipper-flipper-animation") {
          FlipperAnimationSample()
        },
        SampleItem("Hierarchical Background", id: "view-color-flipper-hierarchical-background") {
          HierarchicalBackgroundSample()
        }
      ]),
    SampleSection(
      id: "numbers-data-basic-values",
      title: "NumbersDataBasicValues",
      samples: [
        SampleItem("NumberFormatter", id: "numbers-data-basic-values-number-formatter") {
          NumberFormatterSample()
        }
      ]),
    SampleSection(
      id: "contacts",
      title: "Contacts",
      samples: [
        SampleItem("CNContactStore", id: "contacts-cn-contact-store") { CNContactStoreSample() }
      ]),
    SampleSection(
      id: "shapes-animating-border",
      title: "Shapes",
      samples: [
        SampleItem("AnimatingBorder", id: "shapes-animating-border-animating-border") {
          AnimatingBorderSample()
        }
      ]),
    SampleSection(
      id: "view-sheet",
      title: "View",
      samples: [
        SampleItem(".sheet", id: "view-sheet-sheet") { SheetSample() },
        SampleItem("Automatic Size Sheet", id: "view-sheet-automatic-size-sheet") {
          AutamaticSizeSheetSample()
        }
      ]),
    SampleSection(
      id: "liquid-glass",
      title: "LiquidGlass",
      samples: [
        SampleItem("GlassEffectContainer", id: "liquid-glass-glass-effect-container") {
          GlassEffectContainerSample()
        }
      ]),
    SampleSection(
      id: "optimization",
      title: "Optimization",
      samples: [
        SampleItem("Custom Modifier", id: "optimization-custom-modifier") {
          CustomModifierSample()
        },
        SampleItem("Focused View Components", id: "optimization-focused-view-components") {
          AirportDetails(airport: Airport(id: .TLL, code: .TLL))
        },
        SampleItem("Minimal Dependency", id: "optimization-minimal-dependency") {
          MinimalDependencySample()
        },
        SampleItem("@State Observable", id: "optimization-state-observable") {
          StateObservableSample()
        },
        SampleItem("Value Reference", id: "optimization-value-reference") {
          AnimalModal()
        }
      ]),
    SampleSection(
      id: "images-symbol-shadow",
      title: "Images",
      samples: [
        SampleItem("SymbolImage Shadow", id: "images-symbol-shadow-symbol-image-shadow") {
          SymbolImageShadowSample()
        }
      ])
]

@MainActor public enum SampleCatalog {
  public static let sections: [SampleSection] = sampleSections

  public static var rootItems: [SampleItem] {
    sections.map { section in
      SampleItem(section.title, id: section.id) {
        SamplesList(title: section.title, samples: section.samples)
      }
    }
  }
}
