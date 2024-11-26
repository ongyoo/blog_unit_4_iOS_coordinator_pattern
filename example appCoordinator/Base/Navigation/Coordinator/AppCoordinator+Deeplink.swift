//
//  AppCoordinator+Deeplink.swift
//  example appCoordinator
//
//  Created by Komsit Chusangthong on 11/26/24.
//

extension AppCoordinator {
    // MARK: DeepLink
    func handleDeepLink(with option: DeepLinkOption?) {
        // Handle DeepLink Option
        switch option {
        case .splash: ()
        case .home:
            goToHome()
        case let .detail(param):
            goToDetail(param: param, isPresent: false)
        default: ()
        }
    }
}
