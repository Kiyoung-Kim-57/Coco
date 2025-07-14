import Foundation

extension Data {
    public func toDTO<T: Decodable>(decoder: JSONDecoder) throws -> T {
        let dto = try decoder.decode(T.self, from: self)
        return dto
    }
}
