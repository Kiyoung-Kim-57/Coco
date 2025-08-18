//
//  Router.swift
//  Coco
//
//  Created by 김기영 on 7/1/25.
//

import SwiftUI

public final class CocoFlowRouter<P: Presentable>: FlowRoutable {
    public typealias presentType = P
    
    @Published var presentPath: Array<P>
    
    public init(pathType: P.Type) {
        self.presentPath = Array<P>()
    }
    
    public func presentView(to destination: P) {
        presentPath.append(destination)
    }
    
    public func dismissView() {
        _ = presentPath.popLast()
    }
}

public protocol FlowRoutable: Routable {
    associatedtype presentType
    
    func presentView(to destination: presentType)
    func dismissView()
}
