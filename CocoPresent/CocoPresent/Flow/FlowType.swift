//
//  FlowType.swift
//  Coco
//
//  Created by 김기영 on 7/14/25.
//

public enum FlowType {
    case home
    
    public init(type: any Presentable.Type) {
        switch type {
        case is HomePresent.Type:
            self = .home
        default:
            self = .home
        }
    }
}
