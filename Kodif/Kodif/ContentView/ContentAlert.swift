//
//  SimpleAlert.swift
//  Codif
//
//  Created by Izzat on 16.11.2021.
//

import SwiftUI

struct ContentAlert: View {
    var body: some View {
        VStack {
            Spacer()
            ContentView()
                .frame(maxHeight: 400)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: .gray, radius: 20)
            Spacer()
        }.background(ClearBackground())
    }
}

struct ClearBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
