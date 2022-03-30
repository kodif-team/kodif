//
//  Data.swift
//  Codif
//
//  Created by Izzat on 21.10.2021.
//

import Foundation
struct DataView : Codable {
	let checked : Bool?
    var title : String?
	let value : String?
    var placeholder : String?
	let url : String?
	let dropDownValues : [Entity]?
}
