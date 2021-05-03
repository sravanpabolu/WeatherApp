//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        do {
            try DBManager.shared.saveContext()
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "DB Save Error, while entering background")
        }
    }
}

