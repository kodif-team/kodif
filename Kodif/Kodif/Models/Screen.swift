//
//  Screen.swift
//  Codif
//
//  Created by Izzat on 21.10.2021.
//

import Foundation
struct Screen : Codable, Identifiable {
    let id = UUID()
	let type : String?
	let variable : Variable?
    let variables: [Variables]?
    var data : DataView?
	let action : Action?
	let children : [Screen]?
    let views: [Screen]?
	let config : Config?
    var style : Style?
}
