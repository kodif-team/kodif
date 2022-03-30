//
//  DisclosureGroup.swift
//  Codif
//
//  Created by Izzat on 23.06.2021.
//

import SwiftUI

struct DisclosureGroupView: View {
    
    @State private var isExpanded = false
    @State private var widgetForExpand: Screen?

    private var binding: Binding<String>
    private var view: Screen
    
    init(screen: Screen, binding: Binding<String>) {
        self.binding = binding
        self.view = screen
    }
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ForEach(0..<(view.children?.count ?? 0)) { idx in
                    Button.init {
                        withAnimation {
                            widgetForExpand = view
                            widgetForExpand?.data?.placeholder = view.children?[idx].data?.title ?? ""
                            binding.wrappedValue = view.children?[idx].data?.value ?? ""
                            isExpanded.toggle()
                        }
                    } label: {
                        ContentView(screen: view.children![idx])
                    }
                }
            },
            label: {
                Button.init {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Text((widgetForExpand ?? view).data?.placeholder ?? "")
                        .font(.system(size: CGFloat(view.style?.platformStyle?.ios?.style?.textSize ?? 17)))
                        .setStyle(view.style?.platformStyle?.ios?.style?.textStyle)
                        .setFontWeight(view.style?.platformStyle?.ios?.style?.fontWeight)
                        .foregroundColor(Color(hex:view.style?.commonStyle?.color ?? "#000000"))
                }
            }
        )
            .setPadding(view.style?.platformStyle?.ios?.style?.padding)
            .setFrame(width: view.style?.platformStyle?.ios?.style?.width,
                      height: view.style?.platformStyle?.ios?.style?.height,
                      maxWidth: view.style?.platformStyle?.ios?.style?.maxWidth,
                      maxHeight: view.style?.platformStyle?.ios?.style?.maxHeight,
                      alignment: view.style?.platformStyle?.ios?.style?.alignment)
            .setBackground(view.style?.commonStyle?.backgroundColor)
            .setBorder(view.style?.platformStyle?.ios?.style?.border)
            .opacity(view.style?.commonStyle?.opacity ?? 1)
            .setMarging(view.style?.platformStyle?.ios?.style?.margin)
    }

}
