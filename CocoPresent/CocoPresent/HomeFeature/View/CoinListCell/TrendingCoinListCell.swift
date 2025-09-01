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
    let sparkLine: Data?
    
    public init(_ entity: TrendingCoinListEntity) {
        self.code = entity.code
        self.name = entity.name
        self.price = entity.price
        self.changeRate = entity.changeRate
        self.thumbUrl = entity.thumbUrl
        self.sparkLine = entity.sparkline
    }
    
    public var body: some View {
            HStack {
                coinThumbnail()
                coinLabel()
                Spacer()
                sparkLineView()
                Spacer()
                priceInfoLabel()
            }
    }
    
    private func coinLabel() -> some View {
        VStack(alignment: .leading) {
            CocoLabel(code)
            CocoLabel(
                name,
                font: Font.system(size: SecondaryFont.size),
                textColor: SecondaryFont.color
            )
        }
    }
    
    private func priceInfoLabel() -> some View {
        VStack(alignment: .trailing) {
            priceLabel()
            rateLabel()
        }
    }
    
    private func priceLabel() -> some View {
        return CocoLabel("₩" + formatPrice())
    }
    
    private func formatPrice() -> String {
        return String(format: "%.2f", price)
    }
    
    private func rateLabel() -> some View {
        let textColor = changeRate > 0 ? Color.red : Color.blue
        
        return CocoLabel(
            formatRate() + "%",
            font: Font.system(size: SecondaryFont.size),
            textColor: textColor
        )
    }
    
    private func formatRate() -> String {
        return String(format: "%.1f", changeRate)
    }
    
    @ViewBuilder
    private func sparkLineView() -> some View {
        if let sparkLine {
            SVGProvider.svgImageView(data: sparkLine)
        } else {
            Image(systemName: "chart.xyaxis.line")
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

extension TrendingCoinListCell {
    enum SecondaryFont {
        static let size: CGFloat = 12
        static let color: Color = Color.gray
    }
}

fileprivate let dummyData: TrendingCoinListEntity = TrendingCoinListEntity(
    code: "KYCoin",
    name: "Kiyoung",
    price: 1235,
    changeRate: -52.3,
    thumbUrl: "https://assets.coingecko.com/coins/images/28470/standard/MTLOGO.png?1696527464",
    rank: 0,
    sparkline: Data()
)

#Preview {
    TrendingCoinListCell(dummyData)
}
