//
//  MockNetworkManager.swift
//  CocoDIContainer
//
//  Created by 김기영 on 8/23/25.
//

import Foundation
import CocoNetwork

public final class MockNetworkManager: NetworkManager {
    public func performRequest<T>(request: CocoNetwork.HttpRequest, type: T.Type) async throws -> CocoNetwork.HttpResponse<T> where T : Decodable {
        throw MockError.mockThrows
    }
    
    public func performRequest(request: CocoNetwork.HttpRequest) async throws -> CocoNetwork.HttpResponse<Data> {
        throw MockError.mockThrows
    }
}
