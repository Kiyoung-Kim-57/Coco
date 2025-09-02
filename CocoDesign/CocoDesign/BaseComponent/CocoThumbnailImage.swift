//
//  CocoThumbnailImage.swift
//  CocoDesign
//
//  Created by 김기영 on 8/28/25.
//

import SwiftUI

public struct CocoThumbnailImage: View {
    private let imageName: String
    
    public init(_ imageName: String) {
        self.imageName = imageName
    }
    
    public var body: some View {
        // MARK: 임시로 systemName
        Image(systemName: imageName)
            .resizable()
            .scaledToFill()
            .background(Color.gray)
            .frame(width: 44, height: 44)
            .clipShape(Circle())
    }
}
