import Foundation

public enum Schemes: String {
    case http
    case https
    case ws
    case wss
    
    var string: String { rawValue }
}
