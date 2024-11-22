//
//  SplashInteractor.swift
//  ExsampleAppCoordinator
//
//  Created by Komsit on 18/11/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashBusinessLogic {
    func verifyNextScreen(request: Splash.CheckRootScreen.Request)
}

protocol SplashDataStore {
	var id: String { get set }
    //var usecaseProvider: UseCaseProvider? { get set }
}

final class SplashInteractor: SplashBusinessLogic, SplashDataStore {
	var presenter: SplashPresentationLogic?
	var id: String = ""
    var usecaseProvider: UseCaseProvider?
    
    lazy var worker: SplashWorker? = {
        //guard let usecaseProvider = usecaseProvider else { return nil }
        return SplashWorker()
    }()
	
    func verifyNextScreen(request: Splash.CheckRootScreen.Request) {
        // Handle call api something
        let response = Splash.CheckRootScreen.Response(isLogin: true, isRegister: true)
        presenter?.presentRootView(response: response)
    }
}
