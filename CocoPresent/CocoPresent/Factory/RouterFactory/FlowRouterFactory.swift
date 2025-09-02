//
//  FlowRouterFactory.swift
//  CocoPresent
//
//  Created by 김기영 on 8/27/25.
//

public enum FlowRouterFactory {
    public static func makeHomeFlowRouter() -> some FlowRoutable {
        return CocoFlowRouter(pathType: HomePresent.self)
    }
}
