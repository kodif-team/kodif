//
//  DropDownView.swift
//  Codif
//
//  Created by Izzat on 10.11.2021.
//

import SwiftUI

struct DropDownView: View {
    
    var screen: Screen
    @Binding var selectedItem: Entity?
    
    var body: some View {
        Menu {
            ForEach(0..<(screen.data?.dropDownValues?.count ?? 0)) { idx in
                Button {
                    selectedItem = screen.data?.dropDownValues?[idx]
                } label: {
                    Text(screen.data?.dropDownValues?[idx].value ?? "")
                }
            }
        } label: {
            Text(selectedItem?.value ?? screen.data?.placeholder ?? screen.variable?.value ?? "")
                .font(.system(size: CGFloat(screen.style?.platformStyle?.ios?.style?.textSize ?? 16)))
                .setStyle(screen.style?.platformStyle?.ios?.style?.textStyle)
                .setFontWeight(screen.style?.platformStyle?.ios?.style?.fontWeight)
                .foregroundColor(Color(hex:screen.style?.commonStyle?.color ?? "#000000"))
            Image(systemName: "chevron.down").foregroundColor(Color(hex:screen.style?.commonStyle?.color ?? "#000000"))
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
        .onAppear {
            let key = GlobalData.shared.userInputs[screen.variable!.key!] as? String
            if key == nil {
               GlobalData.shared.userInputs[screen.variable!.key!] = screen.data?.dropDownValues?.first?.value
            }
        }
    }
}

