//
//  Variable.swift
//  Codif
//
//  Created by Izzat on 21.10.2021.
//

import Foundation
struct Variable : Codable {
	let key : String?
	let value : String?
}

struct Variables : Codable {
    var name: String?
    var required : Bool?
    var isMainKey: Bool?
}
