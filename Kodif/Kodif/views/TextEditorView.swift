//
//  TextEditorView.swift
//  Codif
//
//  Created by Izzat on 24.06.2021.
//

import SwiftUI

struct TextEditorView: View {
    private var screen: Screen!
    private var binding: Binding<String>!

    init(screen: Screen, binding: Binding<String>) {
        self.binding = binding
        self.screen = screen
    }

    var body: some View {
        TextEditor(text: binding)
            .font(.system(size: CGFloat(screen.style?.platformStyle?.ios?.style?.textSize ?? 16)))
            .lineLimit(screen.style?.platformStyle?.ios?.style?.lineLimit)
            .lineSpacing(CGFloat(screen.style?.platformStyle?.ios?.style?.lineSpacing ?? 0))
            .foregroundColor(Color(hex:screen.style?.commonStyle?.color ?? "#000000"))
            .setAutocapitalization(screen.style?.platformStyle?.ios?.style?.autocapitalization)
            .setKeyboardType(screen.style?.platformStyle?.ios?.style?.keyboardType)
            .disableAutocorrection(screen.style?.platformStyle?.ios?.style?.disableAutocorrection ?? false)
            .opacity(Double(screen.style?.commonStyle?.opacity ?? 1))
            .setPadding(screen.style?.platformStyle?.ios?.style?.padding)
            .setFrame(width: screen.style?.platformStyle?.ios?.style?.width,
                      height: screen.style?.platformStyle?.ios?.style?.height,
                      maxWidth: screen.style?.platformStyle?.ios?.style?.maxWidth,
                      maxHeight: screen.style?.platformStyle?.ios?.style?.maxHeight,
                      alignment: screen.style?.platformStyle?.ios?.style?.alignment)
            .setBackground(screen.style?.commonStyle?.backgroundColor)
            .setBorder(screen.style?.platformStyle?.ios?.style?.border)
            .setMarging(screen.style?.platformStyle?.ios?.style?.margin)
            .setMultilineTextAlignment(screen.style?.platformStyle?.ios?.style?.multilineTextAlignment)
    }
}
