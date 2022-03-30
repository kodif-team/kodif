//
//  Style.swift
//  Codif
//
//  Created by Izzat on 21.10.2021.
//

import Foundation
struct Style : Codable {
    var commonStyle : CommonStyle?
	let commonAction : CommonAction?
	let platformStyle : PlatformStyle?
}
