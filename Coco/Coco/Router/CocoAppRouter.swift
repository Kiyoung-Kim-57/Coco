//
//  CocoAppRouter.swift
//  Coco
//
//  Created by 김기영 on 7/2/25.
//

import SwiftUI
import Combine

final class CocoAppRouter: AppRoutable {
    static var typeKey: any Any.Type {
        return Self.self
    }
    
    static func createInstance() -> Any {
        return CocoAppRouter()
    }
    
    private var presentFlowType: any Presentable.Type = MainPresent.self
    private var cancellables: Set<AnyCancellable> = Set()
    
    @Published var mainFlowRouter: CocoFlowRouter<MainPresent> = DIContainer.shared.resolve(CocoFlowRouter<MainPresent>.self)
    
    init() {
        bindFlowRouter()
    }
    
    func presentView<P: Presentable>(type: P.Type, to destination: P) {
        if type.self is MainPresent.Type {
            guard let destination = destination as? MainPresent else { return }
            presentMainFlowView(to: destination)
        }
    }
    
    private func presentMainFlowView(to destination: MainPresent) {
        mainFlowRouter.presentView(to: destination)
    }
    
    private func bindFlowRouter() {
        mainFlowRouter.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
}

protocol AppRoutable: Routable { }
