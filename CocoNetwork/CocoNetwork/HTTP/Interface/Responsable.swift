import Foundation

public protocol Responsable {
    associatedtype ResponseType: Decodable
    
    var statusCode: Int { get set }
    var response: ResponseType { get set }
}
