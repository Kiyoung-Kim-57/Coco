//
//  Gecko.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public enum Gecko {
    public static func searchPath() -> String {
        return "/api/v3/search"
    }
    
    public static func trendingPath() -> String {
        return "/api/v3/search/trending"
    }
}
