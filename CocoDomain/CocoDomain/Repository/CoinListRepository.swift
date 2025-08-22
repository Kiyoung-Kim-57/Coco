//
//  CoinListRepository.swift
//  CocoDomain
//
//  Created by 김기영 on 8/23/25.
//
import Foundation

public protocol CoinListRepository {
    func fetchCoinList() -> CoinListEntities
    func fetchCoinThumbnail() -> URL
}
