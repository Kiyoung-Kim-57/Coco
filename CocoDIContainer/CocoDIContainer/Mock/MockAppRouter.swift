//
//  MockAppRouter.swift
//  CocoDIContainer
//
//  Created by 김기영 on 8/18/25.
//
import CocoPresent

public final class MockAppRouter: AppRoutable {
    public func changeFlow(type: CocoPresent.FlowType) {
        print("Change Flow in MockAppRouter")
    }
    
    public func presentView<P>(type: P.Type, to destination: P) where P : CocoPresent.Presentable {
        print("Present View in MockAppRouter")
    }
}
