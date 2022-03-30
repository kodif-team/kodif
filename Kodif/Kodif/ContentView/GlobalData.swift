//
//  GlobalViewModel.swift
//  Codif
//
//  Created by Izzat on 12.11.2021.
//

import SwiftUI

class GlobalData: ObservableObject {
    static let shared = GlobalData()
    private init() {}

    @Published var userInputs = [String: Any]()
    var variables = [Variables]()
}
