//
//  HomeInteractor.swift
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

protocol HomeBusinessLogic {
    func pushDetail()
    func presentDetail()
}

protocol HomeDataStore {
    var detailParam: String? { get set}
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
	var presenter: HomePresentationLogic?
	var worker: HomeWorker?
    var detailParam: String?
    
    // MARK: - Method
    func pushDetail() {
        detailParam = "Push Detail"
        presenter?.presentPushDetail()
    }
    
    func presentDetail() {
        detailParam = "Present Detail"
        presenter?.presentDetail()
    }
}
