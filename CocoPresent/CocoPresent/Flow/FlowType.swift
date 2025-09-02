//
//  FlowType.swift
//  Coco
//
//  Created by 김기영 on 7/14/25.
//

public enum FlowType {
    case home
    case trend
    
    public init(type: any Presentable.Type) {
        switch type {
        case is HomePresent.Type:
            self = .home
        case is TestPresent.Type:
            self = .trend
        default:
            self = .home
        }
    }
}

enum TestPresent: Presentable {
    case test
}
