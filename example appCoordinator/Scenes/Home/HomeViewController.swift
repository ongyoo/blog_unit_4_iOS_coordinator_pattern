//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: AnyObject {
    func displayPushDetail()
    func displayPresentDetail()
}

final class HomeViewController: UIViewController, HomeDisplayLogic, Storyboarded {
	var interactor: HomeBusinessLogic?
	var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing & HomeCoordinator)?

	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	private func setup() {
		let viewController = self
		let interactor = HomeInteractor()
		let presenter = HomePresenter()
		let router = HomeRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	// MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
	// MARK: HomeDisplayLogic
    func displayPushDetail() {
        router?.routeToDetail(presentMode: false)
    }
    
    func displayPresentDetail() {
        router?.routeToDetail(presentMode: true)
    }
    
    // MARK: - Action
    @IBAction private func pushDetailAction(_ sender: UIButton) {
        interactor?.pushDetail()
    }
    
    @IBAction private func presentDetailAction(_ sender: UIButton) {
        interactor?.presentDetail()
    }
}
