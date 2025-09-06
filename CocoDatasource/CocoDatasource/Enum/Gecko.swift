//
//  Gecko.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public enum Gecko {
    public static func searchPath() -> String { "/api/v3/search" }
    
    public static func trendingPath() -> String { "/api/v3/search/trending" }
    
    public static func identifier() -> String { "Gecko" }
}
