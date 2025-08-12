import Foundation

public protocol Responsable {
    associatedtype ResponseType: Decodable
    
    var statusCode: Int { get set }
    var response: ResponseType { get set }
    
    @discardableResult
    func onStatus(_ statusCode: Int, handler: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onStatus(in range: ClosedRange<Int>, handler: @escaping (Self) -> Void) -> Self
    
    @discardableResult
    func onStatus(oneOf statusCodes: [Int], handler: @escaping (Self) -> Void) -> Self
}
