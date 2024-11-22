//
//  AppCoordinator.swift
//  ExsampleAppCoordinator
//
//  Created by TTB on 18/11/2567 BE.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var childCoordinators: [Coordinator] { get set}
    var rootViewController: UIViewController? { get set}
    
    func start()
    func start(with option: DeepLinkOption?)
    func finish(child: Coordinator)
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}

class Coordinator: NSObject, CoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?

    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func start(with option: DeepLinkOption?) {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func finish(child: Coordinator) {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension Coordinator {

    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }

}

final class AppCoordinator: Coordinator {
    let window: UIWindow
    var pendingChildCoordinator: Coordinator?
    
    override var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }

    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        // Create the initial view
        goToSplash(id: "")
    }
    
    override func start(with option: DeepLinkOption?) {
        // Handle DeepLink Option
    }
    
    private func goToSplash(id: String) {
        let splashVC = SplashViewController.instantiate(on: .splash)
        splashVC.router?.coordinator = self
        let navVC = UINavigationController(rootViewController: splashVC)
        navVC.navigationBar.isHidden = true

        guard var destinationDS = splashVC.router?.dataStore else { return }
        passDataToSplash(id: id, destination: &destinationDS)
        rootViewController = navVC
    }
    
    func goToHome() {
        let homeVC = HomeViewController.instantiate(on: .home)
        homeVC.router?.coordinator = self
        pushViewController(homeVC, animated: true)
    }
    
    func goToDetail(param: String, isPresent: Bool) {
        let detailVC = DetailViewController.instantiate(on: .detail)
        guard var destinationDS = detailVC.router?.dataStore else { return }
        passDataToDetail(param: param, destination: &destinationDS)
        detailVC.router?.coordinator = self
        isPresent ? present(detailVC, animated: true) : pushViewController(detailVC, animated: true)
    }
    
    func finishPush(animated flag: Bool) {
        popViewController(animated: flag)
    }
    
    func finishPresent(_ viewController: UIViewController, animated flag: Bool) {
        dismissView(viewController, animated: flag)
    }
}

// MARK: - PassData
private extension AppCoordinator {
    /// Splash
    private func passDataToSplash(id: String, destination: inout SplashDataStore) {
         destination.id = id
    }
    
    /// Detail
    func passDataToDetail(param: String, destination: inout DetailDataStore) {
        destination.param = param
    }
}

// Private
private extension AppCoordinator {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let navigationController = rootViewController as? UINavigationController else { return }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - Present View
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        rootViewController?.present(viewControllerToPresent,
                                    animated: flag, completion: completion)
    }
    
    // MARK: - Pop View
    func popViewController(animated flag: Bool) {
        guard let navigationController = rootViewController as? UINavigationController else { return }
        navigationController.popViewController(animated: flag)
    }
    
    // MARK: - Dismiss View
    func dismissView(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.dismiss(animated: flag, completion: completion)
    }
}

