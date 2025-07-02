//
//  Injection.swift
//  Coco
//
//  Created by 김기영 on 7/3/25.
//

@propertyWrapper
struct Injection<T> {
    private var object: T
    
    init() {
        self.object = DIContainer.shared.resolve(T.self)
    }
    
    var wrappedValue: T {
        object
    }
}
