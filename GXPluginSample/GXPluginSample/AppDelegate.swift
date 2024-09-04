//
//  AppDelegate.swift
//  GXPluginSample
//
//  Created by Gin on 2024/9/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let serialQueue0 = DispatchQueue(label: "com.example.serialQueue")
        NSLog("DispatchQueue start")
        serialQueue0.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction01")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction01") {
                pluginAction(["pluginAction01":"111"])
            }
        }
        serialQueue0.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction02")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction02") {
                pluginAction(["pluginAction02":"111"])
            }
        }
        
        let serialQueue1 = DispatchQueue(label: "com.example.serialQueue1")
        serialQueue1.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction11")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction11") {
                pluginAction(["pluginAction11":"111"])
            }
        }
        serialQueue1.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction12")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction12") {
                pluginAction(["pluginAction12":"111"])
            }
        }
        
        let serialQueue2 = DispatchQueue(label: "com.example.serialQueue2")
        serialQueue2.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction21")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction21") {
                pluginAction(["pluginAction21":"111"])
            }
        }
        serialQueue2.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction22")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction22") {
                pluginAction(["pluginAction22":"111"])
            }
        }
        
        let serialQueue3 = DispatchQueue(label: "com.example.serialQueue3")
        serialQueue3.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction31")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction31") {
                pluginAction(["pluginAction31":"111"])
            }
        }
        serialQueue3.async {
            GXPluginManager.register(pluginAction: { param in
                NSLog("pluginAction param: \(param)")
            }, forKey: "pluginAction32")
            if let pluginAction = GXPluginManager.pluginAction(key: "pluginAction32") {
                pluginAction(["pluginAction32":"111"])
            }
        }
        
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

