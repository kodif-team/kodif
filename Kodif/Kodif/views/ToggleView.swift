//
//  ToggleView.swift
//  Codif
//
//  Created by Izzat on 04.06.2021.
//

import SwiftUI

struct ToggleView: View {
    private var screen: Screen!
    @State private var isOn: Bool = false
    
    init(screen: Screen) {
        self.screen = screen
        isOn = screen.data?.checked ?? false
    }
    
    var body: some View {
        Toggle(screen.data?.title ?? "", isOn: $isOn)
            .toggleStyle(SwitchToggleStyle(tint: Color(hex: screen.style?.platformStyle?.ios?.style?.toggleTintColor ?? "#000000")))
            .setPadding(screen.style?.platformStyle?.ios?.style?.padding)
            .border(Color(hex: screen.style?.platformStyle?.ios?.style?.border?.color ?? "#cccccc"), width: CGFloat(screen.style?.platformStyle?.ios?.style?.border?.width ?? 0))
            .cornerRadius(CGFloat(screen.style?.platformStyle?.ios?.style?.border?.radius ?? 0))
            .opacity(Double(screen.style?.commonStyle?.opacity ?? 1))
            .setFrame(width: screen.style?.platformStyle?.ios?.style?.width,
                      height: screen.style?.platformStyle?.ios?.style?.height,
                      maxWidth: screen.style?.platformStyle?.ios?.style?.maxWidth,
                      maxHeight: screen.style?.platformStyle?.ios?.style?.maxHeight,
                      alignment: screen.style?.platformStyle?.ios?.style?.alignment)
            .setBackground(screen.style?.commonStyle?.backgroundColor)
            .setMarging(screen.style?.platformStyle?.ios?.style?.margin)
            
    }
}

