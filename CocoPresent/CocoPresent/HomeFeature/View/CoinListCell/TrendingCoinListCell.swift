//
//  SearchChartCell.swift
//  CocoPresent
//
//  Created by 김기영 on 8/25/25.
//

import SwiftUI
import CocoDesign
import CocoDomain

public struct TrendingCoinListCell: View {
    let code: String
    let name: String
    let price: Double
    let changeRate: Double
    let thumbUrl: String?
    let sparklineUrl: String?
    
    public init(_ entity: TrendingCoinListEntity) {
        self.code = entity.code
        self.name = entity.name
        self.price = entity.price
        self.changeRate = entity.changeRate
        self.thumbUrl = entity.thumbUrl
        self.sparklineUrl = entity.sparklineUrl
    }
    
    public var body: some View {
//        GeometryReader { geo in
            HStack {
                coinThumbnail()
                coinLabel()
                Spacer()
                sparkLine()
                Spacer()
                priceLabel()
            }
//        }
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
    private func sparkLine() -> some View {
        if let sparklineUrl {
            AsyncImage(url: URL(string: sparklineUrl)) { image in
                image
                    .resizable()
                    .background(Color.gray)
            } placeholder: {
                ProgressView()
            }
        } else {
            CocoThumbnailImage("chart.xyaxis.line")
        }
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
                ProgressView()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
            }
        } else {
            CocoThumbnailImage("bitcoinsign.circle")
        }
    }
}

fileprivate let dummyData: TrendingCoinListEntity = TrendingCoinListEntity(
    code: "KYCoin",
    name: "Kiyoung",
    price: 1235,
    changeRate: 52.3,
    thumbUrl: "https://assets.coingecko.com/coins/images/28470/standard/MTLOGO.png?1696527464",
    rank: 0,
    sparklineUrl: "https://www.coingecko.com/coins/28470/sparkline.svg"
)

#Preview {
    TrendingCoinListCell(dummyData)
}

//public let code: String
//public let name: String
//public let price: Double
//public let changeRate: Double
//public let thumbUrl: String?
//public let rank: Int
//public let sparklineUrl: String?
