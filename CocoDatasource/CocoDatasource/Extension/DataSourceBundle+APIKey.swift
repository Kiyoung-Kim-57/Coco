//
//  DataSourceBundle+APIKey.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/24/25.
//

public extension DataSourceBundle {
    static func coinGeckoAPIKey() -> String {
        guard let apiKey = Self.bundle.infoDictionary?["CoinGeckoApiKey"] as? String else {
            return ""
        }
        
        return apiKey
    }
    
    static func upbitHost() -> String {
        guard let host = Self.bundle.infoDictionary?["UpbitHost"] as? String else {
            return ""
        }
        
        return host
    }
    
    static func geckoHost() -> String {
        guard let host = Self.bundle.infoDictionary?["GeckoHost"] as? String else {
            return ""
        }
        
        return host
    }
}
