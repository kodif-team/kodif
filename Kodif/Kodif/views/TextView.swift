//
//  TextView.swift
//  Codif
//
//  Created by Izzat on 03.06.2021.
//

import SwiftUI

struct TextView: View {
    private var screen: Screen!
    private var needParams = true
    private var isDisabled = false
    
    init(screen: Screen, isDisabled: Bool = false) {
        self.screen = screen
        self.isDisabled = isDisabled
    }
    
    init(screen: Screen, needParams: Bool) {
        self.screen = screen
        self.needParams = needParams
    }
    
    var body: some View {
        if needParams {
            textView
                .opacity(Double(getCommonStyle()?.opacity ?? screen.style?.commonStyle?.opacity ?? 1))
                .setPadding(getPlatformStyle()?.padding ?? screen.style?.platformStyle?.ios?.style?.padding)
                .setFrame(width: getPlatformStyle()?.width ?? screen.style?.platformStyle?.ios?.style?.width,
                          height: getPlatformStyle()?.height ?? screen.style?.platformStyle?.ios?.style?.height,
                          maxWidth: getPlatformStyle()?.maxWidth ?? screen.style?.platformStyle?.ios?.style?.maxWidth,
                          maxHeight: getPlatformStyle()?.maxHeight ?? screen.style?.platformStyle?.ios?.style?.maxHeight,
                          alignment: getPlatformStyle()?.alignment ?? screen.style?.platformStyle?.ios?.style?.alignment)
                .setBackground(getCommonStyle()?.backgroundColor ?? screen.style?.commonStyle?.backgroundColor)
                .setBorder(getPlatformStyle()?.border ?? screen.style?.platformStyle?.ios?.style?.border)
                .setMarging(getPlatformStyle()?.margin ?? screen.style?.platformStyle?.ios?.style?.margin)
            
        } else {
            textView
        }
    }
    
    var textView: some View {
        Text(LocalizedStringKey(screen.data?.title ?? screen.data?.value ?? ""))
            .font(.system(size: CGFloat(getPlatformStyle()?.textSize ?? screen.style?.platformStyle?.ios?.style?.textSize ?? 16)))
            .setStyle(getPlatformStyle()?.textStyle ?? screen.style?.platformStyle?.ios?.style?.textStyle)
            .setFontWeight(getPlatformStyle()?.fontWeight ?? screen.style?.platformStyle?.ios?.style?.fontWeight)
            .strikethrough(getPlatformStyle()?.strikethrough ?? screen.style?.platformStyle?.ios?.style?.strikethrough != nil, color: Color(hex: getPlatformStyle()?.strikethrough ?? screen.style?.platformStyle?.ios?.style?.strikethrough ?? "#000000"))
            .underline(getPlatformStyle()?.underline ?? screen.style?.platformStyle?.ios?.style?.underline != nil, color: Color(hex: getPlatformStyle()?.underline ?? screen.style?.platformStyle?.ios?.style?.underline ?? "#000000"))
            .kerning(CGFloat(getPlatformStyle()?.kerning ?? screen.style?.platformStyle?.ios?.style?.kerning ?? 0))
            .tracking(CGFloat(getPlatformStyle()?.tracking ?? screen.style?.platformStyle?.ios?.style?.tracking ?? 0))
            .baselineOffset(CGFloat(getPlatformStyle()?.baselineOffset ?? screen.style?.platformStyle?.ios?.style?.baselineOffset ?? 0))
            .allowsTightening(getPlatformStyle()?.allowsTightening ?? screen.style?.platformStyle?.ios?.style?.allowsTightening ?? false)
            .minimumScaleFactor(CGFloat(getPlatformStyle()?.minimumScaleFactor ?? screen.style?.platformStyle?.ios?.style?.minimumScaleFactor ?? 0))
            .lineLimit(getPlatformStyle()?.lineLimit ?? screen.style?.platformStyle?.ios?.style?.lineLimit)
            .lineSpacing(CGFloat(getPlatformStyle()?.lineSpacing ?? screen.style?.platformStyle?.ios?.style?.lineSpacing ?? 0))
            .foregroundColor(Color(hex:getCommonStyle()?.color ?? screen.style?.commonStyle?.color ?? "#000000"))
            .setTruncationMode(getPlatformStyle()?.truncationMode ?? screen.style?.platformStyle?.ios?.style?.truncationMode)
            .setMultilineTextAlignment(getPlatformStyle()?.multilineTextAlignment ?? screen.style?.platformStyle?.ios?.style?.multilineTextAlignment)
    }
    
    func getCommonStyle() -> CommonStyle? {
        return isDisabled ? screen.style?.commonAction?.onDisable : screen.style?.commonStyle
    }
    
    func getPlatformStyle() -> StyleIOS? {
        return isDisabled ? screen.style?.platformStyle?.ios?.action?.onDisable : screen.style?.platformStyle?.ios?.style
    }
}
