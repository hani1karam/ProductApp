//
//  AppDelegateManager.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import UIKit
class AppDelegateManager {
    
    var window: UIWindow
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    
    func start() {
        let mainScreenViewController = HomeVC()
        window.rootViewController =  navigatioRootView(mainScreenViewController)
        window.makeKeyAndVisible()
    }
    
    private func navigatioRootView(_ view: UIViewController) -> UINavigationController {
        let rootView = UINavigationController(rootViewController:view)
        rootView.navigationBar.isTranslucent = true
        rootView.navigationBar.standardAppearance = naviagtionAppearance
        rootView.navigationBar.scrollEdgeAppearance = rootView.navigationBar.standardAppearance
        return rootView
    }
    
    private var naviagtionAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.lightGray
        return appearance
    }()
}
