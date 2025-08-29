//
//  SVGProvider.swift
//  CocoDesign
//
//  Created by 김기영 on 8/29/25.
//

import SVGKit

public enum SVGProvider {
    public static func makeUIImage(_ data: Data) -> UIImage? {
        return SVGKImage(data: data).uiImage
    }
}
