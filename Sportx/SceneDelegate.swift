//
//  SceneDelegate.swift
//  SportX
//
//  Created by Zeiad Mohammed on 05/05/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        _ = ConnectivityManager.shared

        window = UIWindow(windowScene: windowScene)

        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

        if hasSeenOnboarding {
            showSplash()
        } else {
            let onboardingVC = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
            onboardingVC.onFinish = { [weak self] in
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                self?.showSplash()
            }
            window?.rootViewController = onboardingVC
            window?.makeKeyAndVisible()
        }
    }

    private func showSplash() {
        let splashVC = SplashViewController()
        splashVC.onFinish = { [weak self] in
            self?.transitionToMainApp()
        }
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }

    private func transitionToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        applyTabBarStyling(to: tabBarController)

        UIView.transition(
            with: window!,
            duration: 0.4,
            options: .transitionCrossDissolve,
            animations: { self.window?.rootViewController = tabBarController }
        )
    }

    private func applyTabBarStyling(to tabBarController: UITabBarController) {
        Theme.styleTabBar(tabBarController.tabBar)
        tabBarController.viewControllers?.forEach { vc in
            if let nav = vc as? UINavigationController {
                Theme.styleNavigationBar(nav.navigationBar)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
