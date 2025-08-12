import Foundation

/// HTTP 요청을 구성하기 위한 구조체
/// 체이닝 가능한 API를 통해 유연하고 타입 안전한 HTTP 요청 생성을 지원합니다.
public struct HttpRequest {
    private let scheme: Schemes
    private let method: HttpMethods
    private var httpBody: Data? = nil
    private var httpHeaders: [String: String] = [:]
    private var urlComponent: URLComponents
    
    /// HttpRequest 초기화
    /// - Parameters:
    ///   - scheme: URL 스킴 (http, https 등)
    ///   - method: HTTP 메서드 (GET, POST, PUT 등)
    public init(scheme: Schemes, method: HttpMethods) {
        self.scheme = scheme
        self.method = method
        self.urlComponent = URLComponents()
        self.urlComponent.scheme = scheme.string
    }
}

// MARK: - Requestable Protocol Implementation
extension HttpRequest: Requestable {
    
    /// 최종 URLRequest 객체 생성
    /// 설정된 모든 파라미터들을 기반으로 URLRequest를 구성합니다.
    /// - Returns: 구성된 URLRequest 객체
    public var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.string
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = httpBody
        
        return request
    }
    
    /// URL 호스트 설정
    /// - Parameter host: 요청할 서버의 호스트명 (예: "api.example.com")
    /// - Returns: 호스트가 설정된 새로운 HttpRequest 인스턴스
    public func setURLHost(host: String) -> Self {
        var request = self
        request.urlComponent.host = host
        return request
    }
    
    /// URL 경로 설정
    /// - Parameter path: API 엔드포인트 경로 (예: "/users/profile")
    /// - Returns: 경로가 설정된 새로운 HttpRequest 인스턴스
    public func setURLPath(path: String) -> Self {
        var request = self
        request.urlComponent.path = path
        return request
    }
    
    /// 쿼리 파라미터 추가
    /// 기존 쿼리 파라미터에 새로운 항목을 추가합니다.
    /// - Parameters:
    ///   - name: 쿼리 파라미터 키
    ///   - value: 쿼리 파라미터 값
    /// - Returns: 쿼리 파라미터가 추가된 새로운 HttpRequest 인스턴스
    public func addQueryItem(_ name: String, _ value: String) -> Self {
        var request = self
        if request.urlComponent.queryItems == nil {
            request.urlComponent.queryItems = []
        }
        request.urlComponent.queryItems?.append(URLQueryItem(name: name, value: value))
        return request
    }
    
    /// 기존 쿼리 파라미터 값 변경
    /// 지정된 이름의 쿼리 파라미터가 존재할 경우 값을 변경합니다.
    /// - Parameters:
    ///   - name: 변경할 쿼리 파라미터의 키
    ///   - value: 새로운 값
    /// - Returns: 쿼리 파라미터가 변경된 새로운 HttpRequest 인스턴스
    /// - Note: 해당 키가 존재하지 않을 경우 변경되지 않습니다.
    public func changeQueryItemValue(_ name: String, _ value: String) -> Self {
        var request = self
        guard var items = request.urlComponent.queryItems,
              let index = items.firstIndex(where: { $0.name == name }) else {
            return request
        }
        
        items[index].value = value
        request.urlComponent.queryItems = items
        return request
    }
    
    /// HTTP 요청 바디 설정
    /// POST, PUT 등의 요청에서 전송할 데이터를 설정합니다.
    /// - Parameter body: 전송할 데이터
    /// - Returns: 바디가 설정된 새로운 HttpRequest 인스턴스
    public func addBody(body: Data) -> Self {
        var request = self
        request.httpBody = body
        return request
    }
    
    /// HTTP 헤더 추가
    /// 요청에 HTTP 헤더를 추가합니다. 같은 키가 존재할 경우 값이 덮어쓰여집니다.
    /// - Parameters:
    ///   - key: 헤더 키 (예: "Content-Type")
    ///   - value: 헤더 값 (예: "application/json")
    /// - Returns: 헤더가 추가된 새로운 HttpRequest 인스턴스
    public func addHeader(key: String, value: String) -> Self {
        var request = self
        request.httpHeaders[key] = value
        return request
    }
}

// MARK: - Convenience Methods
extension HttpRequest {
    
    /// JSON 바디 설정 편의 메서드
    /// Codable 객체를 JSON으로 인코딩하여 바디에 설정하고 Content-Type 헤더를 자동 추가합니다.
    /// - Parameter object: JSON으로 변환할 Codable 객체
    /// - Returns: JSON 바디와 헤더가 설정된 새로운 HttpRequest 인스턴스
    /// - Throws: JSON 인코딩 실패 시 에러
    public func addJSONBody<T: Codable>(_ object: T) throws -> Self {
        let jsonData = try JSONEncoder().encode(object)
        return self
            .addBody(body: jsonData)
            .addHeader(key: "Content-Type", value: "application/json")
    }
    
    /// 인증 토큰 헤더 설정
    /// Bearer 토큰을 Authorization 헤더에 추가합니다.
    /// - Parameter token: 인증 토큰
    /// - Returns: 인증 헤더가 설정된 새로운 HttpRequest 인스턴스
    public func addBearerToken(_ token: String) -> Self {
        return addHeader(key: "Authorization", value: "Bearer \(token)")
    }
    
    /// 다중 쿼리 파라미터 일괄 추가
    /// 딕셔너리 형태의 쿼리 파라미터들을 일괄로 추가합니다.
    /// - Parameter parameters: 추가할 쿼리 파라미터 딕셔너리
    /// - Returns: 쿼리 파라미터들이 추가된 새로운 HttpRequest 인스턴스
    public func addQueryItems(_ parameters: [String: String]) -> Self {
        var request = self
        for (key, value) in parameters {
            request = request.addQueryItem(key, value)
        }
        return request
    }
    
    /// 다중 헤더 일괄 추가
    /// 딕셔너리 형태의 헤더들을 일괄로 추가합니다.
    /// - Parameter headers: 추가할 헤더 딕셔너리
    /// - Returns: 헤더들이 추가된 새로운 HttpRequest 인스턴스
    public func addHeaders(_ headers: [String: String]) -> Self {
        var request = self
        for (key, value) in headers {
            request = request.addHeader(key: key, value: value)
        }
        return request
    }
}
