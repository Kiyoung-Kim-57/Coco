import Foundation

public protocol Requestable {
    var urlRequest: URLRequest { get }
    
    func setURLHost(host: String) -> Self 
    func setURLPath(path: String) -> Self
    func addQueryItem(_ name: String, _ value: String) -> Self
    func addBody(body: Data) -> Self
    func addHeader(key: String, value: String) -> Self
    func changeQueryItemValue(_ name: String, _ value: String) -> Self
}
