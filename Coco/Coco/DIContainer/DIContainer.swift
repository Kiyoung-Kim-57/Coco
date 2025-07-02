//
//  DIContainer.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//

final class DIContainer {
    static let shared = DIContainer()
    
    private init() { }
    
    private var storage: [ObjectIdentifier: Any] = [:]

    func register<T>(_ type: T.Type, instance: T) {
        let key = ObjectIdentifier(type)
        storage[key] = instance
    }
    
    func register<T>(_ instance: T) {
        let key = ObjectIdentifier(type(of: instance))
        storage[key] = instance
    }

    func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(type)
        guard let instance = storage[key] as? T else {
            fatalError("❌ No registered instance for type: \(type)")
        }
        return instance
    }
    
    func unregister<T>(_ type: T.Type) {
        let key = ObjectIdentifier(type)
        storage.removeValue(forKey: key)
    }
    
    func autoRegister(_ types: [AutoRegisterable.Type]) {
        for type in types {
            let key = ObjectIdentifier(type.typeKey)
            if storage[key] == nil {
                storage[key] = type.createInstance()
            } else {
                print("⚠️ [DI] Already registered: \(type.typeKey)")
            }
        }
    }
}
