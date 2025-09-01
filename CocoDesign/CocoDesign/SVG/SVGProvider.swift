//
//  SVGProvider.swift
//  CocoDesign
//
//  Created by 김기영 on 8/29/25.
//

import SwiftUI
import SVGView

public enum SVGProvider {
    public static func svgImageView(data: Data) -> some View {
        return SVGView(data: data)
    }
    
    public static func svgImageView(url: URL) -> some View {
        return SVGView(contentsOf: url)
    }
}
