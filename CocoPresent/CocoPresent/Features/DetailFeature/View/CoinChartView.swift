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
    let chartData: CoinChartDataEntities
    let chartType: CoinChartType
    var bottomValue: Double {
        switch chartType {
        case .price:
            chartData.map { $0.price }.min() ?? 0
        case .marketCap:
            chartData.map { $0.marketCap }.min() ?? 0
        case .totalVolume:
            chartData.map { $0.totalVolume }.min() ?? 0
        }
    }
    
    var topValue: Double {
        switch chartType {
        case .price:
            chartData.map { $0.price }.max() ?? 0
        case .marketCap:
            chartData.map { $0.marketCap }.max() ?? 0
        case .totalVolume:
            chartData.map { $0.totalVolume }.max() ?? 0
        }
    }
    
    var chartPadding: Double {
        (topValue - bottomValue) * 0.2
    }
    
    init(chartData: CoinChartDataEntities, chartType: CoinChartType) {
        self.chartData = chartData
        self.chartType = chartType
    }
    
    var body: some View {
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
        .foregroundStyle(
            chartShapeStyle()
        )
        .chartXAxis {
            AxisMarks(preset: .aligned, values: chartData.map { $0.date }) { value in
                AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
            }
        }
        .chartYAxis {
            AxisMarks{ value in
                AxisValueLabel {
                    if let doubleValue = value.as(Double.self) {
                        Text("\(doubleValue.abbreviated)")
                    }
                }
            }
        }
        .chartYScale(domain: (bottomValue - chartPadding)...(topValue + chartPadding))
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
            width: 20
        )
    }
    
    private func chartShapeStyle() -> some ShapeStyle {
        switch chartType {
        case .price, .marketCap:
            LinearGradient(
                gradient: Gradient(colors: [.blue, .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .totalVolume:
            LinearGradient(
                gradient: Gradient(colors: [.blue, .blue.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

extension CoinChartView {
    enum CoinChartType {
        case price
        case marketCap
        case totalVolume
    }
}
