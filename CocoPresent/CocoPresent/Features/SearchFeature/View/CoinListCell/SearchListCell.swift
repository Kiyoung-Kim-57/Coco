//
//  SearchListCell.swift
//  CocoPresent
//
//  Created by 김기영 on 9/5/25.
//

import SwiftUI
import CocoDesign

struct SearchListCell: View {
    var item: String
    
    init(_ item: String) {
        self.item = item
    }
    
    var body: some View {
        CocoLabel(
            item,
            font: PrimaryFont.font,
            textColor: PrimaryFont.color
        )
    }
}

extension SearchListCell {
    enum PrimaryFont {
        static let font: Font = Font.system(size: 16, weight: .regular)
        static let color: Color = CocoColor.resource(.gray70)
    }
}

#Preview {
    SearchListCell("BitCoin")
}
