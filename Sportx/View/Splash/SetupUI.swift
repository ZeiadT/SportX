//
//  SetupUI.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import UIKit

extension SplashViewController {

    func setupUI() {
        view.backgroundColor = Theme.accentColor
        view.clipsToBounds = true

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "SportX"
        title.textColor = .white
        title.font = .systemFont(ofSize: 42, weight: .bold)
        view.addSubview(title)

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SplashViewController {

    func addPhysics(to balls: [UIImageView]) {
        let gravity = UIGravityBehavior(items: balls)
        gravity.magnitude = 0.8
        animator.addBehavior(gravity)

        let collision = UICollisionBehavior(items: balls)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        let dynamics = UIDynamicItemBehavior(items: balls)
        dynamics.elasticity = 0.8
        dynamics.friction = 0
        dynamics.resistance = 0
        dynamics.angularResistance = 0
        dynamics.allowsRotation = true
        animator.addBehavior(dynamics)

        let push = UIPushBehavior(items: balls, mode: .continuous)
        push.pushDirection = CGVector(
            dx: CGFloat.random(in: -1...1),
            dy: CGFloat.random(in: -0.2...0.2)
        )
        push.magnitude = CGFloat.random(in: 0.3...0.8)
        animator.addBehavior(push)
    }
}

extension SplashViewController {

    func createBalls() {
        var balls: [UIImageView] = []

        for _ in 0..<15 {
            let size = CGFloat.random(in: 70...80)
            let imageView = UIImageView()
            imageView.frame = CGRect(
                x: CGFloat.random(in: 0...(view.bounds.width - size)),
                y: CGFloat.random(in: 50...300),
                width: size,
                height: size
            )
            imageView.image = UIImage(named: "splash-football")
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = size / 2
            imageView.clipsToBounds = true
            view.addSubview(imageView)
            balls.append(imageView)
        }

        addPhysics(to: balls)
    }
}
