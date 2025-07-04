//
//  Router.swift
//  Coco
//
//  Created by 김기영 on 7/1/25.
//

import SwiftUI

final class CocoFlowRouter<P: Presentable>: FlowRoutable {
    static var typeKey: any Any.Type {
        return Self.self
    }
    
    static func createInstance() -> Any {
        return CocoFlowRouter(pathType: P.self)
    }
    
    typealias presentType = P
    
    @Published var presentPath: Array<P>
    
    init(pathType: P.Type) {
        self.presentPath = Array<P>()
    }
    
    func presentView(to destination: P) {
        presentPath.append(destination)
    }
    
    func dismissView() {
        _ = presentPath.popLast()
    }
}

protocol FlowRoutable: Routable {
    associatedtype presentType
    
    func presentView(to destination: presentType)
    func dismissView()
}
