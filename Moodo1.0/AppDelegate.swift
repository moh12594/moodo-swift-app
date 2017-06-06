//
//  AppDelegate.swift
//  Moodo1.0
//
//  Created by Mohamed SADAT on 19/05/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        FirebaseApp.configure()

        
        UITabBar.appearance().tintColor = UIColor(red: 174/255.0, green: 168/255.0, blue: 211/255.0, alpha: 1.0)
        
        UITextField.appearance().tintColor = .black
        
        
        /**let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let root = UIApplication.shared.keyWindow?.rootViewController
        let lc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "firebaseLoginViewController") as! LoginViewController
        let mc: moodViewController = storyboard.instantiateViewController(withIdentifier: "moodViewController") as! moodViewController
        
        if (Auth.auth().currentUser) != nil {
            mc.present(mc, animated: true, completion: nil)
            print("signed in")
        } else {
            // Passing the shortcutItem to the loginVC's variable
            root?.present(lc, animated: true, completion: nil)
        }
        **/
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

