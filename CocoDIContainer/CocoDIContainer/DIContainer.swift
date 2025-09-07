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
    
    public func register<T>(_ type: T.Type, _ instance: T, name: String) {
        let key = "\(ObjectIdentifier(type))" + name
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
//        DIContainer.shared.register(NetworkManagerImpl())
        DIContainer.shared.register(NetworkManager.self, instance: NetworkManagerImpl())
    }
    // DataSource
    static func registerUpbitRemoteDataSource() {
        let networkManager = DIContainer.shared.resolve(NetworkManager.self)
//        DIContainer.shared.register(CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: DataSourceBundle.upbitHost()), name: "Upbit")
        DIContainer.shared.register((any CocoRemoteDataSource).self, CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: Upbit.host()), name: Upbit.identifier())
    }
    
    static func registerGeckoRemoteDataSource() {
        let networkManager = DIContainer.shared.resolve(NetworkManager.self)
//        DIContainer.shared.register(CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: DataSourceBundle.geckoHost()), name: "Gecko")
        DIContainer.shared.register((any CocoRemoteDataSource).self, CocoRemoteDataSourceImpl(networkManager: networkManager, baseHost: Gecko.host()), name: Gecko.identifier())
    }
    
    // Repository
    static func registerCoinListRepository() {
        let upbit = DIContainer.shared.resolve((any CocoRemoteDataSource).self, name: Upbit.identifier())
        let gecko = DIContainer.shared.resolve((any CocoRemoteDataSource).self, name: Gecko.identifier())
        
        DIContainer.shared.register(CoinSearchRepository.self, instance: CoinSearchRepositoryImpl(upbitRemoteDataSource: upbit, geckRemoteDataSource: gecko))
    }
    
    // UseCase
    static func registerFetchCoinListUseCase() {
        let repository = DIContainer.shared.resolve(CoinSearchRepository.self)
        DIContainer.shared.register(FetchCoinListUseCase.self, instance: FetchCoinListUseCaseImpl(coinListRepository: repository))
    }
    
    static func registerFetchTrendingSearchUseCase() {
        let repository = DIContainer.shared.resolve(CoinSearchRepository.self)
        DIContainer.shared.register(FetchTrendingSearchUseCase.self, instance: FetchTrendingSearchUseCaseImpl(coinSearchRepository: repository))
    }
    
    static func registerFetchCoinSearchListUseCase() {
        let repository = DIContainer.shared.resolve(CoinSearchRepository.self)
        DIContainer.shared.register(FetchCoinSearchListUseCase.self, instance: FetchCoinSearchListUseCaseImpl(coinSearchRepository: repository))
    }
    
    public static func registerObjects() {
        registerNetworkManager()
        registerUpbitRemoteDataSource()
        registerGeckoRemoteDataSource()
        registerCoinListRepository()
        registerFetchCoinListUseCase()
        registerFetchTrendingSearchUseCase()
        registerFetchCoinSearchListUseCase()
    }
}

// Resolve
public extension DIContainer {
    static func resolveFetchCoinListUseCase() -> FetchCoinListUseCase {
        return DIContainer.shared.resolve(FetchCoinListUseCase.self)
    }
    
    static func resolveFetchTrendingSearchUseCase() -> FetchTrendingSearchUseCase {
        return DIContainer.shared.resolve(FetchTrendingSearchUseCase.self)
    }
    
    static func resolveFetchCoinSearchListUseCase() -> FetchCoinSearchListUseCase {
        return DIContainer.shared.resolve(FetchCoinSearchListUseCase.self)
    }
}

// Mock
public extension DIContainer {
    static func registerNetworkManagerMock() {
        DIContainer.shared.registerMock((any NetworkManager).self, instance: MockNetworkManager())
    }
    
    static func registerCoinSearchRepositoryMock() {
        DIContainer.shared.registerMock(CoinSearchRepository.self, instance: MockRepository())
    }
    
    static func registerMockObjects() {
        // Mock Register
        registerNetworkManagerMock()
        registerCoinSearchRepositoryMock()
    }
}
