//
//  ProfileController.swift
//  LandCapApp
//
//  Created by Tebin on 9/26/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.secondaryColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleSignOut))
        print("ProfileController")
    }
    @objc func handleSignOut() {
        User.session.isSignedIn = false
        let navigationController = UINavigationController(rootViewController: PageController())
        present(navigationController, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
