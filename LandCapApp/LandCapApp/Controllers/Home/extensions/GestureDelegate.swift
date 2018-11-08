//
//  GestureDelegate.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import UIKit
import CDAlertView

extension HomeController: UIGestureRecognizerDelegate {
    ///UIGestureRecognizerDelegate delegate to handle swip left
    ///Check if the user is anonymous or not
    @objc func handleSwipeToProfile(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if User.session.isAnonymous {
                let alert = CDAlertView(title: App.label.homeAlertTitle, message: App.label.homeAlertMessage, type: .warning)
                alert.show()
            }
            else {
                navigationController?.pushViewController(ProfileController(), animated: true)
            }
        }
    }
}
