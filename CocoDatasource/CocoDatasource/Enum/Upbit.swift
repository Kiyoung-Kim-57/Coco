//
//  Upbit.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/26/25.
//

public enum Upbit {
    public static func host() -> String { "api.upbit.com" }
    
    public static func marketPath() -> String { "/v1/market/all" }
    
    public static func identifier() -> String { "Upbit" }
}
