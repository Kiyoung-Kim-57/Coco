//
//  AppRouterFactory.swift
//  CocoPresent
//
//  Created by 김기영 on 8/27/25.
//

public enum AppRouterFactory {
    public static func makeAppRouter() -> CocoAppRouter {
        let mainFlowRouter = FlowRouterFactory.makeHomeFlowRouter()
        return CocoAppRouter(mainFlowRouter: mainFlowRouter)
    }
}
