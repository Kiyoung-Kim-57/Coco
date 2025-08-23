//
//  DIContainer.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//
import SwiftUI
import CocoDomain
import CocoDatasource
import CocoNetwork
import CocoPresent

public final class DIContainer {
    public static let shared = DIContainer()
    
    private init() { }
    
    private var storage: [ObjectIdentifier: Any] = [:]
    private var mockStorage: [ObjectIdentifier: Any] = [:]
    
    public func register<T>(_ type: T.Type, instance: T) {
        let key = ObjectIdentifier(type)
        storage[key] = instance
    }
    
    public func register<T>(_ instance: T) {
        let key = ObjectIdentifier(type(of: instance))
        storage[key] = instance
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(type)
        guard let instance = storage[key] as? T else {
            fatalError("❌ No registered instance for type: \(type)")
        }
        return instance
    }
    
    // MARK: - Mock Registration
    
    public func registerMock<T>(_ type: T.Type, instance: T) {
        let key = ObjectIdentifier(type)
        mockStorage[key] = instance
    }
    
    public func registerMock<T>(_ instance: T) {
        let key = ObjectIdentifier(type(of: instance))
        mockStorage[key] = instance
    }
    // MARK: - Resolution Methods
    
    public func resolve<T>(_ type: T.Type, mode: InjectionMode = .production) -> T {
        let key = ObjectIdentifier(type)
        
        switch mode {
        case .production:
            return resolveProduction(key: key, type: type)
        case .mock:
            return resolveMock(key: key, type: type)
        }
    }
    
    private func resolveProduction<T>(key: ObjectIdentifier, type: T.Type) -> T {
        if let instance = storage[key] as? T {
            return instance
        }
        
        fatalError("❌ No registered production instance or factory for type: \(type)")
    }
    
    private func resolveMock<T>(key: ObjectIdentifier, type: T.Type) -> T {
        // 1. Mock 인스턴스 확인
        if let instance = mockStorage[key] as? T {
            return instance
        }
        
        return resolveProduction(key: key, type: type)
    }
    
    // MARK: - Cleanup Methods
    public func unregister<T>(_ type: T.Type) {
        let key = ObjectIdentifier(type)
        storage.removeValue(forKey: key)
    }
    
    public func unregisterAll() {
        storage.removeAll()
        mockStorage.removeAll()
    }
    
    public func unregisterMocks() {
        mockStorage.removeAll()
    }
}

// Register
extension DIContainer {
    // Network Manager
    static func registerNetworkManager() {
        DIContainer.shared.register(NetworkManagerImpl())
    }
    // DataSource
    static func registerCocoRemoteDataSource() {
        let networkManager = DIContainer.shared.resolve(NetworkManagerImpl.self)
        DIContainer.shared.register(CocoRemoteDataSourceImpl(networkManager: networkManager))
    }
    
    // Repository
    static func registerCoinListRepository() {
        let dataSource = DIContainer.shared.resolve(CocoRemoteDataSourceImpl.self)
        DIContainer.shared.register(CoinListRepositoryImpl(remoteDataSource: dataSource))
    }
    // UseCase
    static func registerFetchCoinListUseCase() {
        let repository = DIContainer.shared.resolve(CoinListRepositoryImpl.self)
        DIContainer.shared.register(FetchCoinListUseCaseImpl(coinListRepository: repository))
    }
    
    // MainFlowRouter
    static func registerMainFlowRouter() {
        DIContainer.shared.register(CocoFlowRouter(pathType: HomePresent.self))
    }
    
    // AppRouter
    static func registerAppRouter(with mode: InjectionMode = .production) {
        switch mode {
        case .production:
            @Injection var mainFlowRouter: CocoFlowRouter<HomePresent>
            DIContainer.shared.register(CocoAppRouter(mainFlowRouter: mainFlowRouter))
        case .mock:
            @Injection(.mock) var mockFlowRouter: any FlowRoutable
            DIContainer.shared.register(CocoAppRouter(mainFlowRouter: mockFlowRouter))
        }
    }
    
    // MainView
    static func registerMainView() {
        DIContainer.shared.register(MainView())
    }
    
    public static func registerObjects() {
        registerMainFlowRouter()
        registerAppRouter()
        registerMainView()
        registerNetworkManager()
        registerCocoRemoteDataSource()
        registerCoinListRepository()
        registerFetchCoinListUseCase()
        // Mock Register
//        registerFlowRoutableMock()
//        registerAppRoutableMock()
    }
}

// Resolve
public extension DIContainer {
    static func resolveAppRouter() -> CocoAppRouter {
        return DIContainer.shared.resolve(CocoAppRouter.self)
    }
    
    static func resolveMainView() -> MainView {
        return DIContainer.shared.resolve(MainView.self)
    }
    
    static func resolveFetchCoinListUseCase() -> FetchCoinListUseCaseImpl {
        return DIContainer.shared.resolve(FetchCoinListUseCaseImpl.self)
    }
}

// Mock
public extension DIContainer {
    static func registerFlowRoutableMock() {
        DIContainer.shared.registerMock((any FlowRoutable).self, instance: MockFlowRouter())
    }
    
    static func registerAppRoutableMock() {
        DIContainer.shared.registerMock((any AppRoutable).self, instance: MockAppRouter())
    }
    
    static func registerNetworkManagerMock() {
        DIContainer.shared.registerMock((any NetworkManager).self, instance: MockNetworkManager())
    }
    
    static func registerMockObjects() {
        // Mock Register
        registerFlowRoutableMock()
        registerAppRoutableMock()
        registerNetworkManagerMock()
    }
}
