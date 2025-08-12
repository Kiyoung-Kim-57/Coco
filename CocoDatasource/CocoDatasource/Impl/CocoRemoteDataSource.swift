//
//  PLRemoteDataSource.swift
//  PLData
//
//  Created by 김기영 on 1/29/25.
//

import Combine
import Foundation
import CocoNetwork

public final class CocoRemoteDataSource: CocoReadableDataSource {
    public typealias Item = Data
    public typealias Condition = HttpRequest
    
    private let networkManager: NetworkManager
    private let baseHost: String = "api.upbit.com" // 추후 config파일로 따로 관리 예정
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func readData(
        requestHandler: (HttpRequest) -> (HttpRequest) = { return $0 }
    ) async throws -> Item {
        let baseRequest = HttpRequest(scheme: .https, method: .GET).setURLHost(host: baseHost)
        let request = requestHandler(baseRequest)
        let httpResponse = try await networkManager.performRequest(request: request)
        
        return try await handleResponse(httpResponse)
    }
    
    public func readData<T: Decodable>(
        type: T.Type,
        requestHandler: (HttpRequest) -> (HttpRequest) = { return $0 }
    ) async throws -> T {
        let baseRequest = HttpRequest(scheme: .https, method: .GET).setURLHost(host: baseHost)
        let request = requestHandler(baseRequest)
        let httpResponse = try await networkManager.performRequest(request: request, type: type)
        
        return try await handleResponse(httpResponse)
    }
    
    private func handleResponse<T>(_ httpResponse: HttpResponse<T>) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            httpResponse
                .onSuccess { response in
                    continuation.resume(returning: response.response)
                }
                .onStatus(401) { _ in
                    // 인증 에러 처리
                    continuation.resume(throwing: NetworkError.unauthorized)
                    return
                }
                .onStatus(404) { _ in
                    continuation.resume(throwing: NetworkError.notFound)
                    return
                }
                .onServerError { response in
                    continuation.resume(throwing: NetworkError.serverError(response.statusCode))
                    return
                }
                .onAnyError { response in
                    continuation.resume(throwing: NetworkError.networkError(response.statusCode))
                    return
                }
        }
    }
}
