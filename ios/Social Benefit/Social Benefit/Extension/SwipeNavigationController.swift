//
//  SwipeNavigationController.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 11/01/2022.
//

import UIKit
import SwiftUI

final class SwipeNavigationController: UINavigationController {

    // MARK: - Lifecycle

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // This needs to be in here, not in init
        interactivePopGestureRecognizer?.delegate = self
    }

    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }

    // MARK: - Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true

        super.pushViewController(viewController, animated: animated)
    }

    var duringPushAnimation = false

    // MARK: - Custom Functions

    func pushSwipeBackView<Content>(_ content: Content) where Content: View {
        let hostingController = SwipeBackHostingController(rootView: content)
        self.delegate = hostingController
        self.pushViewController(hostingController, animated: true)
    }

}

// MARK: - UINavigationControllerDelegate

extension SwipeNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? SwipeNavigationController else { return }

        swipeNavigationController.duringPushAnimation = false
    }

}

// MARK: - UIGestureRecognizerDelegate

//extension SwipeNavigationController: UIGestureRecognizerDelegate {
//
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard gestureRecognizer == interactivePopGestureRecognizer else {
//            return true // default value
//        }
//
//        // Disable pop gesture in two situations:
//        // 1) when the pop animation is in progress
//        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
//        let result = viewControllers.count > 1 && duringPushAnimation == false
//        return result
//    }
//}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

class SwipeBackHostingController<Content: View>: UIHostingController<Content>, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? SwipeNavigationController else { return }
        swipeNavigationController.duringPushAnimation = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        guard let swipeNavigationController = navigationController as? SwipeNavigationController else { return }
        swipeNavigationController.delegate = nil
    }
}

