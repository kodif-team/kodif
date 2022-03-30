//
//  TimePicker.swift
//  Codif
//
//  Created by Izzat on 09.11.2021.
//

import Foundation
import SwiftUI

struct TimePicker: View {
    private var screen: Screen!
    private var binding: Binding<Date?>!
    
    init(screen: Screen, binding: Binding<Date?>) {
        self.binding = binding
        self.screen = screen
    }
    
    var body: some View {
        DatePickerInputView(date: binding, placeholder: screen.data?.placeholder ?? "Select Time")
            .foregroundColor(Color(hex:screen.style?.commonStyle?.color ?? "#000000"))
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
    }
}
