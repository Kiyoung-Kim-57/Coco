//
//  CocoRemoteDataSourceProtocol.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/23/25.
//
import Foundation
import CocoNetwork

public protocol CocoRemoteDataSource: CocoReadableDataSource where Item == Data, Condition == HttpRequest {
    associatedtype DecodeType: Decodable
}
