//
//  PLDataSource.swift
//  PLData
//
//  Created by 김기영 on 1/29/25.
//

import Foundation

public protocol CocoDataSource {
    associatedtype Item
    associatedtype Condition
}

public protocol CocoReadableDataSource: CocoDataSource {
    func readData(requestHandler: (Condition) -> (Condition)) async throws -> Item
    
//    func readData<T: Decodable>(
//        type: T.Type,
//        requestHandler: (Condition) -> (Condition)
//    ) async throws -> T
}

public protocol CocoWritableDataSource: CocoDataSource {
    // MARK: 쓰기 성공 여부를 Bool값으로 return, 이미 있다면 update 없다면 create
    @discardableResult
    func writeData(
        _ item: Item,
        requestHandler: (Condition) -> (Condition)
    ) async throws -> Bool
}

public protocol CocoDeletableDataSource: CocoDataSource {
    @discardableResult
    func deleteData(
        requestHandler: (Condition) -> (Condition)
    ) async throws -> Bool
}

public typealias CocoDataSourceProtocol = CocoReadableDataSource & CocoWritableDataSource & CocoDeletableDataSource
