//
//  AppDelegate.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/19.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let singleton :Singleton =  Singleton.sharedInstance
    
    let userDefaults = UserDefaults.standard
    
    var window: UIWindow?
    
    override init() {
        super.init()
        FirebaseApp.configure()
        
    }
    
    // アプリが開いたとき
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        // getGoodNumをUserDefaultから取得する
        getGoodNum = userDefaults.object(forKey: "getGoodNum") as? Int ?? 0
        // 追加したお題の語句をUserDefaultから取得できる
        data.whatList = userDefaults.object(forKey: "whatList") as? Int ?? 0
        data.toDoList = userDefaults.object(forKey: "toDoList") as? Int ?? 0
        data.howList = userDefaults.object(forKey: "howList") as? Int ?? 0
        
        return true
    }
    
    // ホームボタンを押したとき
    func applicationWillResignActive(_ application: UIApplication) {
        
        // getGoodNumをUserDefaultに保存する
        userDefaults.set(getGoodNum, forKey: "getGoodNum")
        // 追加したお題の語句をUserDefaultに保存する
        userDefaults.set(data.whatList, forKey: "whatList")
        userDefaults.set(data.toDoList, forKey: "toDoList")
        userDefaults.set(data.howList, forKey: "howList")
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






