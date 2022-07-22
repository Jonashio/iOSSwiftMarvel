//
//  SceneDelegate.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 21/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        do {
            _ = try KeychainHelper.savePublicKey(value: "7de0c9b6d3b848119d11d4701b871780")
            _ = try KeychainHelper.savePrivateKey(value: "cb3091c91cbfa38dd992e81cc8b179f03eabbc50")
        } catch {}
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}
