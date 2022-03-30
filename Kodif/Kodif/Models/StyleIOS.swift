//
//  StyleIOS.swift
//  Codif
//
//  Created by Izzat on 21.10.2021.
//

import Foundation
struct StyleIOS : Codable {
	let containerType : String?
    let alignment: String?
    let width: Double?
    let height: Double?
    let padding : Padding?
    let margin : Padding?
    let border : Border?
    let maxWidth: Bool?
    let maxHeight: Bool?
	let textSize : Int?
	let textStyle : String?
	let fontWeight : String?
	let strikethrough : String?
	let underline : String?
	let kerning : Double?
	let tracking : Double?
	let baselineOffset : Double?
	let allowsTightening : Bool?
	let minimumScaleFactor : Double?
	let truncationMode : String?
	let lineLimit : Int?
	let lineSpacing : Double?
	let renderingMode : String?
	let interpolation : String?
	let aspectRatio : String?
	let multilineTextAlignment : String?
	let autocapitalization : String?
	let disableAutocorrection : Bool?
	let keyboardType : String?
	let toggleTintColor : String?
    let textPosition: String?
    let spaceBetween: Bool?
}
