//
//  ImageView.swift
//  Codif
//
//  Created by Izzat on 01.06.2021.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    private var screen: Screen!
    
    init(screen: Screen) {
        self.screen = screen
        imageLoader = ImageLoader(urlString: screen.data?.url ?? imagePlh)
    }

    var body: some View {
            Image(uiImage: image)
                .resizable()
                .setRenderingMode(screen.style?.platformStyle?.ios?.style?.renderingMode)
                .setInterpolation(screen.style?.platformStyle?.ios?.style?.interpolation)
                .setAspectRatio(screen.style?.platformStyle?.ios?.style?.aspectRatio)
                .setPadding(screen.style?.platformStyle?.ios?.style?.padding)
                .border(Color(hex: screen.style?.platformStyle?.ios?.style?.border?.color ?? "#cccccc"), width: CGFloat(screen.style?.platformStyle?.ios?.style?.border?.width ?? 0))
                .cornerRadius(CGFloat(screen.style?.platformStyle?.ios?.style?.border?.radius ?? 0))
                .opacity(Double(screen.style?.commonStyle?.opacity ?? 1))
                .setFrame(width: screen.style?.platformStyle?.ios?.style?.width,
                          height: screen.style?.platformStyle?.ios?.style?.height,
                          maxWidth: screen.style?.platformStyle?.ios?.style?.maxWidth,
                          maxHeight: screen.style?.platformStyle?.ios?.style?.maxHeight,
                          alignment: screen.style?.platformStyle?.ios?.style?.alignment)
                .setBackground(screen.style?.commonStyle?.backgroundColor)
                .setMarging(screen.style?.platformStyle?.ios?.style?.margin)
                .onAppear {
                    image = UIImage(named: screen.data?.url ?? "") ?? UIImage()
                }
                .onReceive(imageLoader.didChange){ data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
