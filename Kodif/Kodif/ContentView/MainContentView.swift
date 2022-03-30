//
//  SimpleUIView.swift
//  Codif
//
//  Created by Izzat on 16.06.2021.
//

import SwiftUI
import Rollbar
import KustomerChat

struct MainContentView: View {
    
    init(flowUUID: String, initParams: [String: Any]? = nil, kustomerApiKey: String? = nil) {
        K.APIServer.uuId = UUID().uuidString
        K.APIServer.flowUUID = flowUUID
        K.APIServer.initialParams = initParams ?? [String: Any]()
        
        if let kustomerApiKey = kustomerApiKey {
            let _ = Kustomer.configure(apiKey: kustomerApiKey, options: nil, launchOptions: nil)
        }
        
        Rollbar.initWithAccessToken("be7aff5f62ff49d199214bd9b23b9f15")
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ContentView()
            Text("powered by kodif")
                .foregroundColor(Color.gray)
                .font(.system(size: 12))
                .opacity(0.5)
                .padding()
        }
    }
}
