//
//  Extentions.swift
//  Codif
//
//  Created by Izzat on 02.06.2021.
//

import Foundation
import SwiftUI

extension Image {
    func setRenderingMode(_ renderingMode: String?) -> Image {
        switch renderingMode {
        case "none":
            return self.renderingMode(.none)
        case "original":
            return self.renderingMode(.original)
        case "template":
            return self.renderingMode(.template)
        default:
            return self
        }
    }
    
    func setInterpolation(_ interpolation: String?) -> Image {
        switch interpolation {
        case "high":
            return self.interpolation(.high)
        case "low":
            return self.interpolation(.low)
        case "medium":
            return self.interpolation(.medium)
        default:
            return self
        }
    }
}

extension Text {
    func setStyle(_ style: String?) -> Text {
        switch style {
        case "italic":
            return self.italic()
        case "bold":
            return self.bold()
        default:
            return self
        }
    }
    
    func setFontWeight(_ weight: String?) -> Text {
        switch weight {
        case "black":
            return self.fontWeight(.black)
        case "bold":
            return self.fontWeight(.bold)
        case "heavy":
            return self.fontWeight(.heavy)
        case "light":
            return self.fontWeight(.light)
        case "medium":
            return self.fontWeight(.medium)
        case "regular":
            return self.fontWeight(.regular)
        default:
            return self
        }
    }
}


extension View {
    func setFrame(width: Double?, height: Double?, maxWidth: Bool?, maxHeight: Bool?, alignment: String?) -> some View {
        guard let alignment = alignment else {
            return self.frame(
                minWidth: width == nil ? .none : CGFloat(width!),
                maxWidth: maxWidth ?? false ? .infinity: width == nil ? nil : CGFloat(width!),
                minHeight: height == nil ? .none : CGFloat(height!),
                maxHeight: maxHeight ?? false ? .infinity: height == nil ? nil : CGFloat(height!)
            )
        }
        let a: Alignment
        switch alignment {
        case "center":
            a = .center
        case "start":
            a = .leading
        case "end":
            a = .trailing
        case "top":
            a = .top
        case "bottom":
            a = .bottom
        case "topEnd":
            a = .topTrailing
        case "bottomStart":
            a = .bottomLeading
        case "bottomEnd":
            a = .bottomTrailing
        default:
            a = .topLeading
        }
        return self.frame(minWidth: width == nil ? .none : CGFloat(width!),
                          maxWidth: maxWidth ?? false ? .infinity: width == nil ? nil : CGFloat(width!),
                          minHeight: height == nil ? .none : CGFloat(height!),
                          maxHeight: maxHeight ?? false ? .infinity: height == nil ? nil : CGFloat(height!),
                          alignment: a)
    }
    
    func setPadding(_ padding: Padding?) -> some View {
        self.padding(EdgeInsets.init(top: CGFloat(padding?.top ?? 0),
                                     leading: CGFloat(padding?.left ?? 0),
                                     bottom: CGFloat(padding?.bottom ?? 0),
                                     trailing: CGFloat(padding?.right ?? 0)))
    }
    
    func setBorder(_ border: Border?) -> some View {
        
        let a: Alignment
        switch border?.alignment {
        case "start":
            a = .leading
        case "end":
            a = .trailing
        case "top":
            a = .top
        case "bottom":
            a = .bottom
        default:
            a = .center
        }
        
        let width =  (a == .leading || a == .trailing) ? CGFloat(border?.width ?? 0) : nil
        let height =  (a == .bottom || a == .top) ? CGFloat(border?.width ?? 0) : nil
        
        return self.overlay(
            RoundedRectangle(cornerRadius: CGFloat(border?.radius ?? 0))
                .stroke(Color(hex: border?.color ?? "#cccccc"), lineWidth: CGFloat(border?.width ?? 0))
                .frame(width: width, height: height, alignment: a), alignment: a
        ).cornerRadius( CGFloat(border?.radius ?? 0))
    }
    
    func setMarging(_ padding: Padding?) -> some View {
        self.setPadding(padding)
    }
    
    func setBackground(_ color: String?) -> some View {
        if let _color = color {
            return self.background(Color(hex: _color))
        }
        return self.background(Color.clear)
    }
    
    func setMultilineTextAlignment(_ multilineTextAlignment: String?) -> some View {
        switch multilineTextAlignment {
        case "center":
            return self.multilineTextAlignment(.center)
        case "trailing":
            return self.multilineTextAlignment(.trailing)
        default:
            return self.multilineTextAlignment(.leading)
        }
    }
    
    func setTruncationMode(_ truncationMode: String?) -> some View {
        switch truncationMode {
        case "tail":
            return self.truncationMode(.tail)
        case "middle":
            return self.truncationMode(.middle)
        default:
            return self.truncationMode(.head)
        }
    }
    
    func setAspectRatio(_ aspectRatio: String?) -> some View {
        switch aspectRatio {
        case "fill":
            return self.aspectRatio(contentMode: .fill)
        default:
            return self.aspectRatio(contentMode: .fit)
        }
    }
    
    func setAutocapitalization(_ autocapitalization: String?) -> some View {
        switch autocapitalization {
        case "allCharacters":
            return self.autocapitalization(.allCharacters)
        case "sentences":
            return self.autocapitalization(.sentences)
        case "words":
            return self.autocapitalization(.words)
        default:
            return self.autocapitalization(.none)
        }
    }
    
    func setKeyboardType(_ keyboardType: String?) -> some View {
        switch keyboardType {
        case "asciiCapableNumberPad":
            return self.keyboardType(.asciiCapableNumberPad)
        case "asciiCapable":
            return self.keyboardType(.asciiCapable)
        case "URL":
            return self.keyboardType(.URL)
        case "decimalPad":
            return self.keyboardType(.decimalPad)
        case "emailAddress":
            return self.keyboardType(.emailAddress)
        case "namePhonePad":
            return self.keyboardType(.namePhonePad)
        case "numberPad":
            return self.keyboardType(.numberPad)
        case "numbersAndPunctuation":
            return self.keyboardType(.numbersAndPunctuation)
        case "phonePad":
            return self.keyboardType(.phonePad)
        case "twitter":
            return self.keyboardType(.twitter)
        case "webSearch":
            return self.keyboardType(.webSearch)
        case "alphabet":
            return self.keyboardType(.alphabet)
        default:
            return self.keyboardType(.default)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

extension View {
    
    func customFont(_ fontName:String?, _ size: Int?) -> Font {
        let size = CGFloat(size ?? 16)
        
        guard let fontName = fontName else {
            return .system(size: size)
        }
        
        guard let fontUrl = Bundle.main.url(forResource: fontName, withExtension: "ttf") else {
            return .system(size: size)
        }
        
        let fontData = try! Data(contentsOf: fontUrl)
        
        if let provider = CGDataProvider.init(data: fontData as CFData) {
            
            var error: Unmanaged<CFError>?
            
            guard let font:CGFont = CGFont(provider) else { return .system(size: size)}
            if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
                print(error.debugDescription)
                return .custom(fontName, size: size)
            }
        }
        
        return .system(size: size)
    }
}
