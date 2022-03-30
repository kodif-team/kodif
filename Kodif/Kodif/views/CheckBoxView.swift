//
//  CheckBoxView.swift
//  Codif
//
//  Created by Izzat on 23.06.2021.
//

import SwiftUI

struct CheckBoxView: View {
    
    var screen: Screen
    @Binding var checked: Bool
    
    var body: some View {
        getView()
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
    
    @ViewBuilder fileprivate func getView() -> some View {
        let style = screen.style?.platformStyle?.ios?.style
        switch style?.textPosition {
        case "left":
            HStack {
                TextView(screen: screen, needParams: false)
                if style?.spaceBetween ?? false {
                    Spacer()
                } else {
                    EmptyView()
                }
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            }
        default:
            HStack {
                Image(systemName: checked ? "checkmark.square.fill" : "square")
                    .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                if style?.spaceBetween ?? false {
                    Spacer()
                } else {
                    EmptyView()
                }
                TextView(screen: screen, needParams: false)
            }
        }
        
    }
}
