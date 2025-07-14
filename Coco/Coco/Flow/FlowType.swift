//
//  FlowType.swift
//  Coco
//
//  Created by 김기영 on 7/14/25.
//

enum FlowType {
    case home
    
    init(type: any Presentable.Type) {
        switch type {
        case is HomePresent.Type:
            self = .home
        default:
            self = .home
        }
    }
}
