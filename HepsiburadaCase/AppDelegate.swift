//
//  AppDelegate.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = .systemOrange
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .red
        return true
    }

}

