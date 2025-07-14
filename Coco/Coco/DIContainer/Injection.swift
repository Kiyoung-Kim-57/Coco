//
//  Injection.swift
//  Coco
//
//  Created by 김기영 on 7/3/25.
//

import SwiftUI

@propertyWrapper
struct Injection<T> {
    private var object: T
    
    init() {
        self.object = DIContainer.shared.resolve(T.self)
    }
    
    var wrappedValue: T {
        get { object }
        set { object = newValue }
    }
}

@propertyWrapper
struct StateObjectInjection<T: ObservableObject>: DynamicProperty {
    @StateObject private var storage: T
    
    init() {
        _storage = StateObject(wrappedValue: DIContainer.shared.resolve(T.self))
    }
    
    var wrappedValue: T { storage }
    var projectedValue: ObservedObject<T>.Wrapper { $storage }
}
