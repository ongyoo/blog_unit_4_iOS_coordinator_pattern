//
//  DetailRouter.swift
//  ExsampleAppCoordinator
//
//  Created by Komsit on 20/11/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol DetailRoutingLogic {
    func routeFinish()
}

protocol DetailDataPassing {
	var dataStore: DetailDataStore? { get }
}

protocol DetailCoordinator {
    var coordinator: AppCoordinator? { get set }
}

final class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing, DetailCoordinator {
	weak var viewController: DetailViewController?
    weak var coordinator: AppCoordinator?
	var dataStore: DetailDataStore?
	
    func routeFinish() {
        if let vc = viewController,
           let coordinator = coordinator {
            if vc.isModal() {
                coordinator.finishPresent(vc, animated: true)
                return
            }
            coordinator.finishPush(animated: true)
        }
    }
}
