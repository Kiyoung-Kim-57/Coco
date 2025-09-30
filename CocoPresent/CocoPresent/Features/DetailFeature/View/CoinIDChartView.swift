//
//  CoinChartView.swift
//  CocoPresent
//
//  Created by 김기영 on 9/17/25.
//

import SwiftUI
import Charts
import CocoDesign
import CocoDomain

struct CoinIDChartView: View {
    private let chartData: [Double]
    private let isIncreasing: Bool
    
    private func valueRange(_ fn: ([Double]) -> Double?) -> Double {
        let values = chartData
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
    
    init(chartData: [Double], isIncreasing: Bool) {
        self.chartData = chartData
        self.isIncreasing = isIncreasing
    }
    
    var body: some View {
        modifiedChart {
            chartView()
        }
    }
    
    // Chart Views
    private func chartView() -> some View {
        Chart(chartData.enumerated().map { $0 }, id: \.offset) { item in
            areaChart(item.offset, item.element)
        }
    }
    
    private func areaChart(_ index: Int, _ value: Double) -> some ChartContent {
        AreaMark(
            x: .value("Index", index),
            yStart: .value("Baseline", bottomValue - chartPadding),
            yEnd: .value("Price", value)
        )
        .interpolationMethod(.cardinal)
    }
    // Chart Shape Modifiers
    private func modifiedChart(@ViewBuilder _ content: () -> (some View)) -> some View {
        content()
            .foregroundStyle(
                isIncreasing ?
                CoinChartStyle.areaIncreasingGradient :
                CoinChartStyle.areaDecreasingGradient
            )
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartYScale(domain: chartDomainRange)
    }
    
    // Axis Content
    private func xAxisMarks() -> some AxisContent {
        AxisMarks(preset: .aligned, values: chartData.enumerated().map { $0.offset }) { value in
            AxisValueLabel()
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

extension CoinIDChartView {
    enum CoinChartStyle {
        static let areaDecreasingGradient = LinearGradient(
            gradient: Gradient(colors: [CocoColor.resource(.blue), .clear]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let areaIncreasingGradient = LinearGradient(
            gradient: Gradient(colors: [CocoColor.resource(.red), .clear]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    enum Constants {
        static let barWidth: MarkDimension = 20
    }
}
