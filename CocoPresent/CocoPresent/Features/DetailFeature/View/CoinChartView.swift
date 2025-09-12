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
    
    private func valueRange(_ fn: ([Double]) -> Double?) -> Double {
        let values = chartData.map { $0[keyPath: chartType.keyPath] }
        return fn(values) ?? 0
    }

    var bottomValue: Double {
        valueRange { $0.min() }
    }

    var topValue: Double {
        valueRange { $0.max() }
    }
    
    var chartPadding: Double {
        (topValue - bottomValue) * 0.2
    }
    
    var chartDomainRange: ClosedRange<Double> {
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
            width: 20
        )
    }
    
    // Chart Shape Modifiers
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
}
