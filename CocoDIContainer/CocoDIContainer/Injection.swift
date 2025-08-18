//
//  Injection.swift
//  Coco
//
//  Created by 김기영 on 7/3/25.
//

import SwiftUI
import Combine

/// 통합 주입 프로퍼티 래퍼
@propertyWrapper
public struct Injection<T> {
    private var object: T
    
    /// Production 모드로 주입 (기본값)
    public init() {
        self.object = DIContainer.shared.resolve(T.self, mode: .production)
    }
    
    /// 지정된 모드로 주입
    public init(_ mode: InjectionMode) {
        self.object = DIContainer.shared.resolve(T.self, mode: mode)
    }
    
    public var wrappedValue: T {
        get { object }
        set { object = newValue }
    }
}

/// StateObject용 통합 주입 프로퍼티 래퍼
@propertyWrapper
public struct StateObjectInjection<T: ObservableObject>: DynamicProperty {
    @StateObject private var storage: T
    
    /// Production 모드로 주입 (기본값)
    public init() {
        self._storage = StateObject(wrappedValue: DIContainer.shared.resolve(T.self, mode: .production))
    }
    
    /// 지정된 모드로 주입
    public init(_ mode: InjectionMode) {
        self._storage = StateObject(wrappedValue: DIContainer.shared.resolve(T.self, mode: mode))
    }
    
    public var wrappedValue: T { storage }
    public var projectedValue: ObservedObject<T>.Wrapper { $storage }
}

