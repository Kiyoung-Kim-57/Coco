//
//  Router.swift
//  Coco
//
//  Created by 김기영 on 7/1/25.
//

import SwiftUI

final class CocoStackRouter<P: Presentable>: StackRoutable {
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

protocol StackRoutable: Routable {
    associatedtype presentType
    
    func presentView(to destination: presentType)
    func dismissView()
}
