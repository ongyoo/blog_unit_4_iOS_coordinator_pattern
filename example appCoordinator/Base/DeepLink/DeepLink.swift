//
//  DeepLink.swift
//  ExsampleAppCoordinator
//
//  Created by Komsit on 20/11/2567 BE.
//

import Foundation

enum DeepLinkOption {
    case splash, home
    case detail(param: String)
    
    var rawValue: String {
        switch self {
        case .home:
            return "home"
        case .splash:
            return "splash"
        case .detail:
            return "detail"
        }
    }
    
    static func from(path: String, parameters: [String: String]? = nil) -> DeepLinkOption? {
            switch path {
            case DeepLinkOption.splash.rawValue:
                return .splash
            case DeepLinkOption.home.rawValue:
                return .home
            case DeepLinkOption.detail(param: "").rawValue:
                if let param = parameters?["param"] {
                    return .detail(param: param)
                } else {
                    return .detail(param: "")
                }
            default:
                return nil
            }
    }
}

struct DeepLinkManager {
    static let shared = DeepLinkManager()
    
    func resolve(_ url: URL) -> DeepLinkOption? {
        guard let path = url.pathComponents.dropFirst().first else { return nil }
        let parameters = url.queryParameters
        return DeepLinkOption.from(path: path, parameters: parameters)
    }
}
