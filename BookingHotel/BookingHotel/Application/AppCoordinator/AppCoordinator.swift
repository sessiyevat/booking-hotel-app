//
//  AppCoordinator.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/22/23.
//

import SwiftUI

open class AppCoordinator<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    
    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        push(route)
    }
    
    public func push(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
            case .push:
                navigationController.pushViewController(viewController, animated: animated)
            case .presentModally:
                viewController.modalPresentationStyle = .formSheet
                navigationController.present(viewController, animated: animated)
            case .presentFullscreen:
                viewController.modalPresentationStyle = .fullScreen
                navigationController.present(viewController, animated: animated)
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
}
