import Foundation

public final class NetworkManagerImpl: NetworkManager {
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    public static let shared = NetworkManagerImpl()
    
    public init() { }
    
    public func performRequest<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T> {
        let (data, response) = try await urlSession.data(for: request.urlRequest())
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let statusCode: Int = response.statusCode
        let dto: T = try data.toDTO(decoder: decoder)
        let httpResponse = HttpResponse(statusCode: statusCode, response: dto)
        
        return httpResponse
    }
    
    public func performRequest(request: HttpRequest) async throws -> HttpResponse<Data> {
        let (data, response) = try await urlSession.data(for: request.urlRequest())
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let statusCode: Int = response.statusCode
        let httpResponse = HttpResponse(statusCode: statusCode, response: data)
        
        return httpResponse
    }
    
    public func data(url: URL) async throws -> HttpResponse<Data> {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let statusCode: Int = response.statusCode
        let httpResponse = HttpResponse(statusCode: statusCode, response: data)
        
        return httpResponse
    }
}


