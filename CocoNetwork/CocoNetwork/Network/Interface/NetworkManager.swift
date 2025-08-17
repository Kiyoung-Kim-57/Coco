import Foundation

public protocol NetworkManager {
    func performRequest<T: Decodable>(request: Requestable, type: T.Type) async throws -> Responsable<T>
    func performRequest(request: Requestable) async throws -> Responsable<Data>
}
