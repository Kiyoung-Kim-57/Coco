//
//  Gecko.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public enum Gecko {
    public static func host() -> String { "api.coingecko.com" }
    
    public static func searchPath() -> String { "/api/v3/search" }
    
    public static func trendingPath() -> String { "/api/v3/search/trending" }
    
    public static func marketChartPath(_ id: String) -> String { "/api/v3/coins/\(id)/market_chart" }
    
    public static func identifier() -> String { "Gecko" }
}
