//
//  SplashViewController.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import UIKit

final class SplashViewController: UIViewController {

    var onFinish: (() -> Void)?
    var animator: UIDynamicAnimator!
    private var didSetup = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !didSetup else { return }
        didSetup = true

        animator = UIDynamicAnimator(referenceView: view)
        createBalls()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.onFinish?()
        }
    }
}
