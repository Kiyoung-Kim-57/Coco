import Foundation

public struct HttpResponse<T: Decodable>: Responsable {
    public typealias ResponseType = T
    
    public var statusCode: Int
    public var response: ResponseType
    private var isResponseHandled: Bool = false
    
    /// HttpResponse 초기화 (내부 생성용)
    /// - Parameters:
    ///   - statusCode: HTTP 상태 코드
    ///   - response: 응답 데이터
    public init(statusCode: Int, response: ResponseType) {
        self.statusCode = statusCode
        self.response = response
    }
}

// MARK: - Status Code Handling Extensions
extension HttpResponse {
    
    /// 특정 상태 코드에 대한 핸들러 등록
    /// - Parameters:
    ///   - statusCode: 처리할 상태 코드
    ///   - handler: 해당 상태 코드일 때 실행할 클로저
    /// - Returns: 체이닝을 위한 self
    @discardableResult
    public func onStatus(_ statusCode: Int, handler: @escaping (Self) -> Void) -> Self {
        guard !isResponseHandled else { return self }
        
        var updatedSelf = self
        if self.statusCode == statusCode {
            updatedSelf.isResponseHandled = true
            handler(updatedSelf)
        }
        return updatedSelf
    }
    
    /// 상태 코드 범위에 대한 핸들러 등록
    /// - Parameters:
    ///   - range: 처리할 상태 코드 범위 (예: 200...299)
    ///   - handler: 해당 범위일 때 실행할 클로저
    /// - Returns: 체이닝을 위한 self
    @discardableResult
    public func onStatus(in range: ClosedRange<Int>, handler: @escaping (Self) -> Void) -> Self {
        guard !isResponseHandled else { return self }
        
        var updatedSelf = self
        if range.contains(statusCode) {
            updatedSelf.isResponseHandled = true
            handler(updatedSelf)
        }
        return updatedSelf
    }
    
    /// 여러 상태 코드에 대한 핸들러 등록
    /// - Parameters:
    ///   - statusCodes: 처리할 상태 코드들
    ///   - handler: 해당 상태 코드들 중 하나일 때 실행할 클로저
    /// - Returns: 체이닝을 위한 self
    @discardableResult
    public func onStatus(oneOf statusCodes: [Int], handler: @escaping (Self) -> Void) -> Self {
        guard !isResponseHandled else { return self }
        
        var updatedSelf = self
        if statusCodes.contains(statusCode) {
            updatedSelf.isResponseHandled = true
            handler(updatedSelf)
        }
        return updatedSelf
    }
}

// MARK: - Convenience Methods (Using Base onStatus Methods)
extension HttpResponse {
    
    /// 성공 응답 처리 (200-299)
    @discardableResult
    public func onSuccess(handler: @escaping (Self) -> Void) -> Self {
        return onStatus(in: 200...299, handler: handler)
    }
    
    /// 인증 에러 처리 (401, 403)
    @discardableResult
    public func onAuthError(handler: @escaping (Self) -> Void) -> Self {
        return onStatus(oneOf: [401, 403], handler: handler)
    }
    
    /// 기타 클라이언트 에러 처리 (400-499, 단 401, 403 제외)
    @discardableResult
    public func onClientError(handler: @escaping (Self) -> Void) -> Self {
        guard !isResponseHandled else { return self }
        
        if (400...499).contains(statusCode) && ![401, 403].contains(statusCode) {
            return onStatus(statusCode, handler: handler)
        }
        return self
    }
    
    /// 서버 에러 처리 (500-599)
    @discardableResult
    public func onServerError(handler: @escaping (Self) -> Void) -> Self {
        return onStatus(in: 500...599, handler: handler)
    }
    
    /// 리다이렉션 처리 (300-399)
    @discardableResult
    public func onRedirection(handler: @escaping (Self) -> Void) -> Self {
        return onStatus(in: 300...399, handler: handler)
    }
    
    /// 모든 에러 응답 처리 (300-599)
    @discardableResult
    public func onAnyError(handler: @escaping (Self) -> Void) -> Self {
        return onStatus(in: 300...599, handler: handler)
    }
}
