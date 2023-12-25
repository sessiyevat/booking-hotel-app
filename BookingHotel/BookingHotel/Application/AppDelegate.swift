//
//  AppDelegate.swift
//  BookingHotel
//
//  Created by Tomiris Sessiyeva on 12/22/23.
//

import UIKit

@main
final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sessionRole = connectingSceneSession.role
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: sessionRole)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}
