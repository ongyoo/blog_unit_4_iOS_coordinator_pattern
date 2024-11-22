//
//  Storyboarded.swift
//  ExsampleAppCoordinator
//
//  Created by TTB on 18/11/2567 BE.
//

import Foundation
import UIKit

enum Storyboard {
    case splash
    case home
    case detail

    var name: String {
        switch self {
        case .splash:
            return "Splash"
        case .home:
            return "Home"
        case .detail:
            return "Detail"
        }
    }
}

protocol Storyboarded {
    static func instantiate(on storyboard: Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {

    static func instantiate(on storyboard: Storyboard) -> Self {
        // this pulls out "_ios.LoginSelectionViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)

        // swiftlint:disable force_cast
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        // swiftlint:enable force_cast
    }
}

extension Storyboarded where Self: UITabBarController {

    static func instantiate(on storyboard: Storyboard) -> Self {
        // this pulls out "oaplus_ios.LoginSelectionViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)

        // swiftlint:disable force_cast
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        // swiftlint:enable force_cast
    }
}

