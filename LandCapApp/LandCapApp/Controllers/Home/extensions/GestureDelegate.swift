//
//  GestureDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit

extension HomeController: UIGestureRecognizerDelegate {
    @objc func handleSwipeToProfile(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            navigationController?.pushViewController(ProfileController(), animated: true)
        }
    }
}
