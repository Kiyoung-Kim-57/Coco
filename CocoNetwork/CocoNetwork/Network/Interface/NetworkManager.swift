import Foundation

public protocol NetworkManager {
    func fetchData<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T>
    func fetchData(request: HttpRequest) async throws -> HttpResponse<Data>
}
