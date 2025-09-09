//
//  CoinSearchListEntity.swift
//  CocoDomain
//
//  Created by 김기영 on 9/5/25.
//

import Foundation

public struct CoinSearchListEntity: Equatable, Hashable {
    public let id: String
    public let name: String
    public let symbol: String
    
    public init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
}

public typealias CoinSearchListEntities = [CoinSearchListEntity]
