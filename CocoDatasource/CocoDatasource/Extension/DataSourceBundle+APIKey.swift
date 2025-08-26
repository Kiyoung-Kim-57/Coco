//
//  DataSourceBundle+APIKey.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/24/25.
//

public extension DataSourceBundle {
    static func coinGeckoAPIKey() -> String {
        guard let apiKey = Self.bundle.infoDictionary?[InfoKey.coinGeckoApiKey()] as? String else {
            return ""
        }
        
        return apiKey
    }
    
    static func upbitHost() -> String {
        guard let host = Self.bundle.infoDictionary?[InfoKey.upbitHost()] as? String else {
            return ""
        }
        
        return host
    }
    
    static func geckoHost() -> String {
        guard let host = Self.bundle.infoDictionary?[InfoKey.geckoHost()] as? String else {
            return ""
        }
        
        return host
    }
}

private enum InfoKey {
    static func coinGeckoApiKey() -> String { return "CoinGeckoApiKey" }
    
    static func upbitHost() -> String { return "UpbitHost" }
    
    static func geckoHost() -> String { return "GeckoHost" }
}
