import Foundation

public enum NetworkError: Error {
    case notFound
    case unauthorized
    case serverError(Int)
    case networkError(Int)
}
