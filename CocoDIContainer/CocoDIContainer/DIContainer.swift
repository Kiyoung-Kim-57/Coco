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
    
    private var storage: [String: Any] = [:]
    private var mockStorage: [String: Any] = [:]
    public func register<T>(_ type: T.Type, instance: T) {
        let key = "\(ObjectIdentifier(type))"
        storage[key] = instance
    }
    
    public func register<T>(_ instance: T) {
        let key = "\(ObjectIdentifier(type(of: instance)))"
        storage[key] = instance
    }
    
    public func register<T>(_ instance: T, name: String) {
        let key = "\(ObjectIdentifier(type(of: instance)))" + name
        storage[key] = instance
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = "\(ObjectIdentifier(type))"
        guard let instance = storage[key] as? T else {
            fatalError("❌ No registered instance for type: \(type)")
        }
        return instance
    }
    
    public func resolve<T>(_ type: T.Type, name: String) -> T {
        let key = "\(ObjectIdentifier(type))" + name
        guard let instance = storage[key] as? T else {
            fatalError("❌ No instance for type: \(type), name: \(name)")
        }
        return instance
    }
    
    // MARK: - Mock Registration
    
    public func registerMock<T>(_ type: T.Type, instance: T) {
        let key = "\(ObjectIdentifier(type))"
        mockStorage[key] = instance
    }
    
    public func registerMock<T>(_ instance: T) {
        let key = "\(ObjectIdentifier(type(of: instance)))"
        mockStorage[key] = instance
    }
    // MARK: - Resolution Methods
    
    public func resolve<T>(_ type: T.Type, mode: InjectionMode = .production) -> T {
        let key = "\(ObjectIdentifier(type))"
        
        switch mode {
        case .production:
            return resolveProduction(key: key, type: type)
        case .mock:
            return resolveMock(key: key, type: type)
        }
    }
    
    private func resolveProduction<T>(key: String, type: T.Type) -> T {
        if let instance = storage[key] as? T {
            return instance
        }
        
        fatalError("❌ No registered production instance or factory for type: \(type)")
    }
    
    private func resolveMock<T>(key: String, type: T.Type) -> T {
        // 1. Mock 인스턴스 확인
        if let instance = mockStorage[key] as? T {
            return instance
        }
        
        return resolveProduction(key: key, type: type)
    }
    
    // MARK: - Cleanup Methods
    public func unregister<T>(_ type: T.Type) {
        let key = "\(ObjectIdentifier(type))"
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
    static func registerUpbitRemoteDataSource() {
        let networkManager = DIContainer.shared.resolve(NetworkManagerImpl.self)
        DIContainer.shared.register(CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: DataSourceBundle.upbitHost()), name: "Upbit")
    }
    
    static func registerGeckoRemoteDataSource() {
        let networkManager = DIContainer.shared.resolve(NetworkManagerImpl.self)
        DIContainer.shared.register(CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: DataSourceBundle.geckoHost()), name: "Gecko")
    }
    
    // Repository
    static func registerCoinListRepository() {
        let upbit = DIContainer.shared.resolve(CocoRemoteDataSourceImpl.self, name: "Upbit")
        let gecko = DIContainer.shared.resolve(CocoRemoteDataSourceImpl.self, name: "Gecko")
        
        DIContainer.shared.register(CoinSeachRepositoryImpl(upbitRemoteDataSource: upbit, geckRemoteDataSource: gecko))
    }
    // UseCase
    static func registerFetchCoinListUseCase() {
        let repository = DIContainer.shared.resolve(CoinSeachRepositoryImpl.self)
        DIContainer.shared.register(FetchCoinListUseCaseImpl(coinListRepository: repository))
    }
    
    static func registerFetchTrendingSearchUseCase() {
        let repository = DIContainer.shared.resolve(CoinSeachRepositoryImpl.self)
        DIContainer.shared.register(FetchTrendingSearchUseCaseImpl(coinSearchRepository: repository))
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
    
    public static func registerObjects() {
        registerMainFlowRouter()
        registerAppRouter()
        registerNetworkManager()
        registerUpbitRemoteDataSource()
        registerGeckoRemoteDataSource()
        registerCoinListRepository()
        registerFetchCoinListUseCase()
        registerFetchTrendingSearchUseCase()
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
    
    static func resolveFetchCoinListUseCase() -> FetchCoinListUseCaseImpl {
        return DIContainer.shared.resolve(FetchCoinListUseCaseImpl.self)
    }
    
    static func resolveFetchTrendingSearchUseCase() -> FetchTrendingSearchUseCaseImpl {
        return DIContainer.shared.resolve(FetchTrendingSearchUseCaseImpl.self)
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
