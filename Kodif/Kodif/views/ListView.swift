//
//  ListView.swift
//  Codif
//
//  Created by Izzat on 03.06.2021.
//

import SwiftUI

struct ListView: View {
    
    private var screen: Screen!
    
    init(screen: Screen) {
        self.screen = screen
    }
    
    var body: some View {
        List(screen.children ?? [Screen]()) { row in
            ContentView(screen: row)
        }
        .listStyle(PlainListStyle())
        .setPadding(screen.style?.platformStyle?.ios?.style?.padding)
        .setFrame(width: screen.style?.platformStyle?.ios?.style?.width,
                  height: screen.style?.platformStyle?.ios?.style?.height,
                  maxWidth: screen.style?.platformStyle?.ios?.style?.maxWidth,
                  maxHeight: screen.style?.platformStyle?.ios?.style?.maxHeight,
                  alignment: screen.style?.platformStyle?.ios?.style?.alignment)
        .setBackground(screen.style?.commonStyle?.backgroundColor)
        .setBorder(screen.style?.platformStyle?.ios?.style?.border)
        .opacity(screen.style?.commonStyle?.opacity ?? 1)
        .setMarging(screen.style?.platformStyle?.ios?.style?.margin)
    }
}
