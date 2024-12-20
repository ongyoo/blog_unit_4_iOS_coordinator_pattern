//
//  DetailModels.swift
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

enum Detail {
	// MARK: Use cases
	
	enum Something {
		struct Request {
		}
		struct Response {
		}
		struct ViewModel {
		}
	}
    
    enum GetParam {
        struct Request {
            var param: String?
        }
        struct Response {
            var param: String?
        }
        
        struct ViewModel {
            var param: String?
        }
    }
}
