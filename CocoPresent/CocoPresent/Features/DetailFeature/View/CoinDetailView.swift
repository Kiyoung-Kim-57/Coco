//
//  CoinDetailView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/9/25.
//

import SwiftUI
import ComposableArchitecture
import CocoDesign
import CocoDomain

struct CoinDetailView: View {
    let store: StoreOf<CoinDetailFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                coinInfoLabel(
                    name: sampleCoinEntity.name,
                    code: sampleCoinEntity.symbol,
                    price: sampleCoinEntity.currentPrice.krw
                )
                
                ScrollView {
                    // Chart
                    chartView(sampleCoinEntity.sparkLine, isIncreasing: false)
                    // Detail Info Containers
                }
                .navigationTitle(sampleCoinEntity.name)
            }
            
        }
    }
    
    private func coinInfoLabel(name: String, code: String, price: Double) -> some View {
        HStack(alignment: .lastTextBaseline) {
            coinNameLabel(name, code: code)
            Spacer()
            priceLabel(price)
        }
        .padding(.horizontal, 12)
    }
    
    private func coinNameLabel(_ name: String, code: String) -> some View {
        VStack(alignment: .leading) {
            CocoLabel(
                name,
                font: PrimaryFont.font,
                textColor: PrimaryFont.color
            )
            CocoLabel(
                code,
                font: SecondaryFont.font,
                textColor: SecondaryFont.color
            )
        }
    }
    
    private func priceLabel(_ price: Double) -> some View {
        CocoLabel(
            "₩ \(price)",
            font: PriceFont.font,
            textColor: PriceFont.color
        )
    }
    
    private func chartView(_ data: [Double], isIncreasing: Bool) -> some View {
        CoinIDChartView(
            chartData: data,
            isIncreasing: isIncreasing
        )
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding(16)
    }
    
    private func allTimeInfos() -> some View {
        CocoContainer {
            
        }
    }
}

extension CoinDetailView {
    enum PrimaryFont {
        static let font: Font = Font.system(size: 30, weight: .bold)
        static let color: Color = .black
    }
    
    enum SecondaryFont {
        static let font: Font = Font.system(size: 24, weight: .regular)
        static let color: Color = CocoColor.resource(.gray50)
    }
    
    enum PriceFont {
        static let font: Font = Font.system(size: 28, weight: .semibold)
        static let color: Color = CocoColor.resource(.gray70)
    }
    
    enum Insets {
        static let chartInset: EdgeInsets = EdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 5
        )
    }
}

fileprivate let sampleCoinEntity = CoinDataByIDEntity(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    categories: ["Cryptocurrency", "Layer 1"],
    currentPrice: CurrencyPrice(usd: 27000.50, krw: 36120000),
    ath: CurrencyPrice(usd: 69000.00, krw: 82000000),
    athChangePercentage: CurrencyPercentage(usd: -60.9, krw: -56.0),
    athDate: CurrencyDate(krw: "2021-11-10T09:00:00Z", usd: "2021-11-10T09:00:00Z"),
    atl: CurrencyPrice(usd: 67.81, krw: 73000),
    atlChangePercentage: CurrencyPercentage(usd: 39700.0, krw: 49000.0),
    atlDate: CurrencyDate(krw: "2013-07-06T00:00:00Z", usd: "2013-07-06T00:00:00Z"),
    sparkLine: [
        Double.random(in: 20000...30000),
        Double.random(in: 20000...30000),
        Double.random(in: 20000...30000),
        Double.random(in: 20000...30000),
        Double.random(in: 20000...30000),
        Double.random(in: 20000...30000),
        Double.random(in: 20000...35000),
        Double.random(in: 20000...35000),
        Double.random(in: 20000...36000),
        Double.random(in: 20000...35000),
        Double.random(in: 20000...35000),
    ],
    lastUpdated: "2025-09-30T09:00:00Z"
)

#Preview {
    CoinDetailView(store: Store(initialState: CoinDetailFeature.State(), reducer: {
        CoinDetailFeature()
    }))
}
