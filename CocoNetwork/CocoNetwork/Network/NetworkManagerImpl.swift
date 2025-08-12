import Foundation

public final class NetworkManagerImpl: NetworkManager {
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    public init() { }
    
    public func performRequest<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
        let dto: T = try data.toDTO(decoder: decoder)
        let httpResponse = HttpResponse(statusCode: statusCode, response: dto)
        
        return httpResponse
    }
    
    public func performRequest(request: HttpRequest) async throws -> HttpResponse<Data> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
        let httpResponse = HttpResponse(statusCode: statusCode, response: data)
        
        return httpResponse
    }
}


