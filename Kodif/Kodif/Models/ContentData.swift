//
//  ContentData.swift
//  Codif
//
//  Created by Izzat on 03.11.2021.
//

import Foundation
struct ContentData : Codable {
    let success : Bool?
    let manifests : [Manifest]?
    let errorDetails: String?
}

struct Manifest : Codable {
    let json : String?
    let type : String?
}
