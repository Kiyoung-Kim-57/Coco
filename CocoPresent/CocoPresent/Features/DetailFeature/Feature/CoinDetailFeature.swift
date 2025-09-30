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
    }
    
    public enum Action {
        case viewDidAppear(String)
        case loadData
        case dataLoaded(CoinDataByIDEntity)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewDidAppear(let id):
                state.coinID = id
                
                return .run { send in
                    await send(.loadData)
                }
                
            case .loadData:
                let id = state.coinID
                
                return .run { send in
                    let coinDetails = try await fetchCoinDataByIDUseCase.execute(id)
                    
                    await send(.dataLoaded(coinDetails))
                }
                
            case .dataLoaded(let data):
                state.coinDetails = data
                return .none
            }
        }
    }
    
    
}

