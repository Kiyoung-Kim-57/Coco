//
//  CocoAppRouter.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//

import SwiftUI
import Combine

protocol AppRoutable: Routable {
    func changeFlow(type: FlowType)
    func presentView<P: Presentable>(type: P.Type, to destination: P)
}

final class CocoAppRouter: AppRoutable {
    static var typeKey: any Any.Type {
        return Self.self
    }
    
    static func createInstance() -> Any {
        return CocoAppRouter()
    }
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    @Published var presentFlowType: FlowType = .home
    @Published var mainFlowRouter: CocoFlowRouter<HomePresent> = DIContainer.shared.resolve(CocoFlowRouter<HomePresent>.self)
    
    init() {
        bindFlowRouter()
    }
    
    func changeFlow(type: FlowType) {
        presentFlowType = type
    }
    
    func presentView<P: Presentable>(type: P.Type, to destination: P) {
        if type.self is HomePresent.Type {
            guard presentFlowType == FlowType(type: type),
                let destination = destination as? HomePresent else { return }
            presentMainFlowView(to: destination)
        }
    }
    
    private func presentMainFlowView(to destination: HomePresent) {
        mainFlowRouter.presentView(to: destination)
    }
    
    private func bindFlowRouter() {
        [mainFlowRouter.objectWillChange].forEach {
            $0
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        }
    }
}
