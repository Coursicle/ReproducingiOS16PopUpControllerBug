//
//  AppDelegate.swift
//  testHello
//
//  Created by Joe Puccio on 8/17/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension UIApplication {
        
        /// Sweeter: `keyWindow` for scene-based apps
        public var legacyKeyWindow: UIWindow? {
            if #available(iOS 13, *) {
                return windows.first { $0.isKeyWindow }
            } else {
                return keyWindow
            }
        }

        
    /// Sweeter: Returns the currently top-most view controller.
    public class func topViewController(base: UIViewController? = UIApplication.shared.legacyKeyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    /// Sweeter: Show `viewController` over the top-most view controller.
    public class func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            topViewController()?.present(viewController, animated: animated, completion: completion)
        }
    }
}

