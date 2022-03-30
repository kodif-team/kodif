//
//  RadioView.swift
//  Codif
//
//  Created by Izzat on 10.11.2021.
//

import SwiftUI

struct RadioView: View {
    
    var screen: Screen
    @Binding var checked: Bool
    
    var body: some View {
        HStack {
            TextView(screen: screen, needParams: false)
            Spacer()
            Image(systemName: checked ? "largecircle.fill.circle" : "circle")
                .foregroundColor(checked ? Color(hex:screen.style?.commonStyle?.color ?? "#000000") : Color.secondary)
        }
        .onTapGesture {
            self.checked.toggle()
        }
        .setPadding(screen.style?.platformStyle?.ios?.style?.padding)
        .opacity(Double(screen.style?.commonStyle?.opacity ?? 1))
        .setFrame(width: screen.style?.platformStyle?.ios?.style?.width,
                  height: screen.style?.platformStyle?.ios?.style?.height,
                  maxWidth: screen.style?.platformStyle?.ios?.style?.maxWidth,
                  maxHeight: screen.style?.platformStyle?.ios?.style?.maxHeight,
                  alignment: screen.style?.platformStyle?.ios?.style?.alignment)
        .setBackground(screen.style?.commonStyle?.backgroundColor)
        .setBorder(screen.style?.platformStyle?.ios?.style?.border)
        .setMarging(screen.style?.platformStyle?.ios?.style?.margin)
    }
}
