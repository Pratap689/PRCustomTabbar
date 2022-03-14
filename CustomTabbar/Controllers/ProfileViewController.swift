//
//  ProfileViewController.swift
//  CustomTabbar
//
//  Created by netset on 11/03/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.profilePageColor
        btnLogout.layer.cornerRadius = 8
    }
}
