import Foundation

public enum HttpMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var string: String { rawValue }
}
