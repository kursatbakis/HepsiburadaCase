//
//  SceneDelegate.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
    }
}

