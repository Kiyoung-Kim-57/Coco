//
//  MockFlowRouter.swift
//  CocoDIContainer
//
//  Created by 김기영 on 8/18/25.
//

import CocoPresent

public final class MockFlowRouter: FlowRoutable {
    public typealias presentType = String
    
    public func presentView(to destination: String) {
        print("Present View To \(destination)")
    }
    
    public func dismissView() {
        print("Dismiss View")
    }
}
