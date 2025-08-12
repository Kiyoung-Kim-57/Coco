import Foundation

public protocol NetworkManager {
    func performRequest<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T>
    func performRequest(request: HttpRequest) async throws -> HttpResponse<Data>
}
