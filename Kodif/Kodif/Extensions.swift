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
