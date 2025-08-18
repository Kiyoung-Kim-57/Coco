//
//  CocoAppRouter.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//

import SwiftUI
import Combine

public protocol AppRoutable: Routable {
    @MainActor func changeFlow(type: FlowType)
    @MainActor func presentView<P: Presentable>(type: P.Type, to destination: P)
}

public final class CocoAppRouter: AppRoutable {
    private var cancellables: Set<AnyCancellable> = Set()
    
    @Published var presentFlowType: FlowType = .home
    @Published var mainFlowRouter: any FlowRoutable
    
    public init(mainFlowRouter: any FlowRoutable) {
        self.mainFlowRouter = mainFlowRouter
        
        Task { @MainActor in
            bindFlowRouter()
        }
    }
    
    @MainActor
    public func changeFlow(type: FlowType) {
        presentFlowType = type
    }
    
    @MainActor
    public func presentView<P: Presentable>(type: P.Type, to destination: P) {
        if type.self is HomePresent.Type {
            guard presentFlowType == FlowType(type: type),
                let destination = destination as? HomePresent else { return }
            presentMainFlowView(to: destination)
        }
    }
    
    @MainActor
    private func presentMainFlowView(to destination: HomePresent) {
        guard let mainFlowRouter = mainFlowRouter as? CocoFlowRouter<HomePresent> else { return }
        
        mainFlowRouter.presentView(to: destination)
    }
    
    @MainActor
    private func bindFlowRouter() {
        guard let mainFlowRouter = mainFlowRouter as? CocoFlowRouter<HomePresent> else { return }
        
        [mainFlowRouter.objectWillChange].forEach {
            $0
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        }
    }
}
