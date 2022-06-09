//
//  AppDelegate.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appDelegateManager: AppDelegateManager?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDelegateManager = AppDelegateManager()
        appDelegateManager?.start()
        setRoot()
        _ = CoreDataHelper.shared.persistentContainer.viewContext
        return true
    }
    func setRoot(){
        let navigationController = UINavigationController(rootViewController: HomeVC())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
