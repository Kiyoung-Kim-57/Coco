//
//  CoinDetailFeature.swift
//  CocoPresent
//
//  Created by 김기영 on 9/26/25.
//

import SwiftUI
import ComposableArchitecture
import CocoDomain

public struct CoinDetailFeature: Reducer {
    public init() { }
    
    @Dependency(\.fetchCoinDataByIDUseCase) var fetchCoinDataByIDUseCase
    
    public struct State: Equatable {
        var coinID: String = ""
        var coinDetails: CoinDataByIDEntity? = nil
        var isIncreasing: Bool = true
    }
    
    public enum Action {
        case onAppear(String)
        case loadData
        case dataLoaded(CoinDataByIDEntity)
        case dataLoadFailed(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear(let id):
                state.coinID = id
                
                return .run { send in
                    await send(.loadData)
                }
                
            case .loadData:
                let id = state.coinID
                
                return .run { send in
                    do {
                        let coinDetails = try await fetchCoinDataByIDUseCase.execute(id)
                        
                        await send(.dataLoaded(coinDetails))
                    } catch {
                        await send(.dataLoadFailed(error))
                    }
                }
                
            case .dataLoaded(let data):
                state.coinDetails = data
                
                if let details = state.coinDetails,
                   details.sparkLine.count > 1 {
                    let count = details.sparkLine.count
                    state.isIncreasing = details.sparkLine[count - 1] > details.sparkLine[count - 2]
                }
                
                return .none
                
            case .dataLoadFailed(let error):
                // TODO: Error Handling
                return .none
            }
        }
    }
    
    
}

