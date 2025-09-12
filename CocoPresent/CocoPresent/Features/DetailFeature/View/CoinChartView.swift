//
//  CoinChartView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/11/25.
//

import SwiftUI
import Charts
import CocoDesign
import CocoDomain

struct CoinChartView: View {
    private let chartData: CoinChartDataEntities
    private let chartType: CoinChartType
    
    private func valueRange(_ fn: ([Double]) -> Double?) -> Double {
        let values = chartData.map { $0[keyPath: chartType.keyPath] }
        return fn(values) ?? 0
    }

    private var bottomValue: Double {
        valueRange { $0.min() }
    }

    private var topValue: Double {
        valueRange { $0.max() }
    }
    
    private var chartPadding: Double {
        (topValue - bottomValue) * 0.2
    }
    
    private var chartDomainRange: ClosedRange<Double> {
        (bottomValue - chartPadding)...(topValue + chartPadding)
    }
    
    init(chartData: CoinChartDataEntities, chartType: CoinChartType) {
        self.chartData = chartData
        self.chartType = chartType
    }
    
    var body: some View {
        modifiedChart {
            chartView()
        }
    }
    
    // Chart Views
    private func chartView() -> some View {
        Chart(chartData) { data in
            switch chartType {
            case .price:
                areaChart(data.date, data.price)
            case .marketCap:
                areaChart(data.date, data.marketCap)
            case .totalVolume:
                barChart(data.date, data.totalVolume)
            }
        }
    }
    
    private func areaChart(_ date: Date, _ value: Double) -> some ChartContent {
        AreaMark(
            x: .value("Date", date),
            yStart: .value("Baseline", bottomValue - chartPadding),
            yEnd: .value("Price", value)
        )
        .interpolationMethod(.catmullRom)
    }
    
    private func barChart(_ date: Date, _ value: Double) -> some ChartContent {
        BarMark(
            x: .value("Date", date),
            yStart: .value("Baseline", bottomValue - chartPadding),
            yEnd: .value("Price", value),
            width: Constants.barWidth
        )
    }
    
    // Chart Shape Modifiers
    private func modifiedChart(@ViewBuilder _ content: () -> (some View)) -> some View {
        content()
            .foregroundStyle(
                chartShapeStyle()
            )
            .chartXAxis {
                xAxisMarks()
            }
            .chartYAxis {
                yAxisMarks()
            }
            .chartYScale(domain: chartDomainRange)
    }
    
    private func chartShapeStyle() -> some ShapeStyle {
        switch chartType {
        case .price, .marketCap:
            CoinChartStyle.areaGradient
        case .totalVolume:
            CoinChartStyle.barGradient
        }
    }
    
    // Axis Content
    private func xAxisMarks() -> some AxisContent {
        AxisMarks(preset: .aligned, values: chartData.map { $0.date }) { value in
            AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
        }
    }
    
    private func yAxisMarks() -> some AxisContent {
        AxisMarks{ value in
            AxisValueLabel {
                if let doubleValue = value.as(Double.self) {
                    Text("\(doubleValue.abbreviated)")
                }
            }
        }
    }
}

extension CoinChartView {
    enum CoinChartType {
        case price
        case marketCap
        case totalVolume
        
        var keyPath: KeyPath<CoinChartDataEntity, Double> {
            switch self {
            case .price: return \.price
            case .marketCap: return \.marketCap
            case .totalVolume: return \.totalVolume
            }
        }
    }
    
    enum CoinChartStyle {
        static let areaGradient = LinearGradient(
            gradient: Gradient(colors: [.blue, .clear]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let barGradient = LinearGradient(
            gradient: Gradient(colors: [.blue, .blue.opacity(0.9)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    enum Constants {
        static let barWidth: MarkDimension = 20
    }
}
//
//
//#Preview("CoinChartView - Price") {
//    CoinChartView(
//        chartData: CoinChartDataEntities.previewData,
//        chartType: .totalVolume
//    )
//    .frame(width: 300, height: 200)
//    .padding()
//}
//
//extension CoinChartDataEntities {
//    static var previewData: CoinChartDataEntities {
//        let now = Date()
//        return (0..<7).map { offset in
//            let date = Calendar.current.date(byAdding: .day, value: -offset, to: now)!
//            return CoinChartDataEntity(
//                date: date,
//                price: Double.random(in: 20000...30000),
//                marketCap: Double.random(in: 5_000_000_000...10_000_000_000),
//                totalVolume: Double.random(in: 500_000_000...1_500_000_000)
//            )
//        }
//        .sorted { $0.date < $1.date }
//    }
//}
