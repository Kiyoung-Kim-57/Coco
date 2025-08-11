//
//  CocoAppRouter.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//

import SwiftUI
import Combine

protocol AppRoutable: Routable {
    @MainActor func changeFlow(type: FlowType)
    @MainActor func presentView<P: Presentable>(type: P.Type, to destination: P)
}

final class CocoAppRouter: AppRoutable {
    static var typeKey: any Any.Type {
        return Self.self
    }
    
    static func createInstance() -> Any {
        return CocoAppRouter()
    }
    
    private var cancellables: Set<AnyCancellable> = Set()
    
    @Published private var presentFlowType: FlowType = .home
    @Published private var mainFlowRouter: CocoFlowRouter<HomePresent> = DIContainer.shared.resolve(CocoFlowRouter<HomePresent>.self)
    
    init() {
        Task { @MainActor in
            bindFlowRouter()
        }
    }
    
    @MainActor
    func changeFlow(type: FlowType) {
        presentFlowType = type
    }
    
    @MainActor
    func presentView<P: Presentable>(type: P.Type, to destination: P) {
        if type.self is HomePresent.Type {
            guard presentFlowType == FlowType(type: type),
                let destination = destination as? HomePresent else { return }
            presentMainFlowView(to: destination)
        }
    }
    
    @MainActor
    private func presentMainFlowView(to destination: HomePresent) {
        mainFlowRouter.presentView(to: destination)
    }
    
    @MainActor
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
