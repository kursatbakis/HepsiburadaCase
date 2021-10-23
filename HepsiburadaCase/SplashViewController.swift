//
//  SplashViewController.swift
//  HepsiburadaCase
//
//  Created by Kursat on 22.10.2021.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let hepsiburadaImageView = UIImageView(image: UIImage(named: "hepsiburada"))
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(hepsiburadaImageView)
        view.backgroundColor = .white
        hepsiburadaImageView.translatesAutoresizingMaskIntoConstraints = false
        hepsiburadaImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        hepsiburadaImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        hepsiburadaImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        hepsiburadaImageView.clipsToBounds = true
        hepsiburadaImageView.contentMode = .scaleAspectFit
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33) {
                self.hepsiburadaImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33) {
                self.hepsiburadaImageView.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.34) {
                self.hepsiburadaImageView.transform = CGAffineTransform(rotationAngle: .pi * -1)
            }
        } completion: { (_) in
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: GridViewController())
        }
    }
}
