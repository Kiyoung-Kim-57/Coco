//
//  SearchChartCell.swift
//  CocoPresent
//
//  Created by 김기영 on 8/25/25.
//

import SwiftUI
import CocoDesign

public struct TrendingCoinListCell: View {
    let code: String
    let name: String
    let price: Double
    let changeRate: Double
    let thumbUrl: String?
    let sparklineUrl: String?
    
    public var body: some View {
        HStack {
            coinThumbnail()
            coinLabel()
            Spacer()
            priceLabel()
        }
    }
    
    private func coinLabel() -> some View {
        VStack(alignment: .leading) {
            CocoLabel(code)
            CocoLabel(name)
        }
    }
    
    private func priceLabel() -> some View {
        return CocoLabel("₩" + formatPrice())
    }
    
    private func formatPrice() -> String {
        return String(format: "%.2f", price)
    }
    
    @ViewBuilder
    private func coinThumbnail() -> some View {
        if let thumbUrl {
            AsyncImage(url: URL(string: thumbUrl)) { image in
                image
                    .resizable()
                    .background(Color.gray)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
            } placeholder: {
                CocoThumbnailImage("person.fill")
            }
        } else {
            CocoThumbnailImage("person.fill")
        }
    }
}

//#Preview {
//    TrendingCoinListCell(code: "ETH", name: "Ethereum", price: 1235)
//}

//public let code: String
//public let name: String
//public let price: Double
//public let changeRate: Double
//public let thumbUrl: String?
//public let rank: Int
//public let sparklineUrl: String?
