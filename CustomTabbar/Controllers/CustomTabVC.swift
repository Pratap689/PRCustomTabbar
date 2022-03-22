//
//  RabbarControllerViewController.swift
//  CustomTabbar
//
//  Created by Pratap Rana on 10/03/22.
//

import UIKit

class CustomTabBar: UITabBarController {
    private var viewLeadingConst: NSLayoutConstraint!
    var value: CGFloat = 0.0
    var selectedImagee: UIImage?
    var selectedTitle: String?
    var movingViewTrailingConst: NSLayoutConstraint!
    var profileViewCenterXConst: NSLayoutConstraint!
    var itemWidth: CGFloat  {
        Constants.screenWidth/CGFloat(tabBar.items?.count ?? 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            self?.setupTabFont()
            self?.setupCustomTabBar()
            self?.setLayouts()
        }
    }
    
    var updateCurrentItem: Int? = nil {
        didSet {
            if oldValue != selectedIndex {
                updateTabUI()
            }
        }
    }
    private func setupCustomTabBar() {
        self.tabBar.layer.insertSublayer(CustomTabView.customTabView(tabBar.bounds) ?? CAShapeLayer(), at: 0)
        if let items = tabBar.items {
            let _ = items.map { tabItem in
                tabItem.imageInsets = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
            }
        }
        selectedIndex = 4
    }
    
    private func setupTabFont() {
        delegate = self
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: Constants.applabelColor]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)], for: .selected)
    }
    
    private let selectedView: UIView = {
        let profileView = UIView()
        profileView.tag = 0
        profileView.backgroundColor = Constants.profilePageColor
        profileView.tintColor = .white
        profileView.layer.cornerRadius = 18
        profileView.isUserInteractionEnabled = false
        profileView.layer.shadowColor = UIColor.gray.cgColor
        profileView.layer.shadowOffset = CGSize(width: 0, height: -1)
        profileView.layer.shadowRadius = 5
        profileView.layer.shadowOpacity = 0.3
        profileView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private let tabbarImage: UIImageView = {
        let tabImage = UIImageView()
        tabImage.contentMode = .scaleAspectFit
        tabImage.translatesAutoresizingMaskIntoConstraints = false
        return tabImage
    }()
    
    private var tabItemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kaysee"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = Constants.applabelColor
        return label
    }()
    
    private let userInfoTitle: UILabel = {
        let label = UILabel()
        label.text = "L3"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = Constants.applabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func updateTabUI() {
        self.tabbarImage.image = self.selectedImagee
        self.tabItemTitle.text = self.selectedTitle
    }
    
    private let profileView: UIImageView = {
        let profileView = UIImageView()
        profileView.image = UIImage(named: "profileimg")
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private let profileBackView: UIImageView = {
        let profileBackView = UIImageView()
        profileBackView.image = UIImage(named: "userbackImg")
        profileBackView.translatesAutoresizingMaskIntoConstraints = false
        return profileBackView
    }()
    
    private let badgeView: UIView = {
        let badgeView = UIView()
        badgeView.backgroundColor = UIColor.init(red: 88/255, green: 100/255, blue: 247/255, alpha: 1)
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.layer.cornerRadius = 7.5
        return badgeView
    }()
    
    private let badgeCount: UILabel = {
        let badgeCount = UILabel()
        badgeCount.text = "1"
        badgeCount.textColor = .white
        badgeCount.font = .systemFont(ofSize: 8)
        badgeCount.textAlignment = .center
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        return badgeCount
    }()
    
    private let profileViewContainer: UIView = {
        let profileViewContainer = UIView()
        profileViewContainer.isUserInteractionEnabled = false
        profileViewContainer.alpha = 0
        profileViewContainer.translatesAutoresizingMaskIntoConstraints = false
        return profileViewContainer
    }()
        
    private let tabItemsContainerView: UIView = {
        let vew = UIView()
        vew.translatesAutoresizingMaskIntoConstraints = false
        vew.backgroundColor = .cyan
        return vew
    }()
    
    private let stackView: UIStackView = {
        let stckVew = UIStackView()
        stckVew.axis = .vertical
        stckVew.translatesAutoresizingMaskIntoConstraints = false
        return stckVew
    }()
    
    private let xpCount_label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "+32 XP"
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        lbl.textColor = UIColor.init(red: 88/255, green: 100/255, blue: 247/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private func addItemsInstackView() {
        stackView.addArrangedSubview(tabbarImage)
        stackView.addArrangedSubview(tabItemTitle)
    }
    
    private func updateUI() {
        view.insertSubview(profileViewContainer, at: selectedIndex == 4 ? 3: 2)
        stackView.isHidden = selectedIndex == 4 ? true: false
    }
    
    private func addProfileViewLayoyts(isAddingOnMainView: Bool = true) {
        updateUI()
        profileViewContainer.addSubview(profileBackView)
        profileViewContainer.addSubview(profileView)
        profileViewContainer.addSubview(badgeView)
        badgeView.addSubview(badgeCount)
        NSLayoutConstraint.activate([
            profileViewContainer.widthAnchor.constraint(equalToConstant: 35),
            profileViewContainer.heightAnchor.constraint(equalToConstant: 35),
            profileViewContainer.topAnchor.constraint(equalTo: selectedView.topAnchor, constant: 30),
            profileBackView.widthAnchor.constraint(equalToConstant: 32),
            profileBackView.heightAnchor.constraint(equalToConstant: 32),
            profileBackView.centerYAnchor.constraint(equalTo: profileViewContainer.centerYAnchor),
            profileBackView.centerXAnchor.constraint(equalTo: profileViewContainer.centerXAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 25),
            profileView.heightAnchor.constraint(equalToConstant: 25),
            profileView.centerYAnchor.constraint(equalTo: profileBackView.centerYAnchor),
            profileView.centerXAnchor.constraint(equalTo: profileBackView.centerXAnchor),
            badgeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: 15),
            badgeView.bottomAnchor.constraint(equalTo: profileViewContainer.bottomAnchor, constant: -5),
            badgeView.leadingAnchor.constraint(equalTo: profileViewContainer.leadingAnchor, constant: -2),
            badgeCount.topAnchor.constraint(equalTo: badgeView.topAnchor, constant: 3),
            badgeCount.leadingAnchor.constraint(equalTo: badgeView.leadingAnchor, constant: 3),
            badgeCount.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: -3),
            badgeCount.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: -3)
        ])
        profileViewCenterXConst = profileViewContainer.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -itemWidth/2 + 5)
        profileViewCenterXConst.isActive = true
    }
    
    private func setLayouts() {
        view.addSubview(selectedView)
        selectedView.addSubview(stackView)
        addItemsInstackView()
        NSLayoutConstraint.activate([
            selectedView.widthAnchor.constraint(equalToConstant: tabBar.bounds.size.width / 5 - 3),
            selectedView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, constant: 43),
            selectedView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: selectedView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: selectedView.topAnchor, constant: 28),
        ])
        movingViewTrailingConst = selectedView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -15)
        movingViewTrailingConst.isActive = true
        addProfileViewLayoyts(isAddingOnMainView: false)
        addXPCountlbl()
    }
    
    private func animateProfileViewWithFadeAnimation() {
        UIView.animate(withDuration: 3) {
            self.profileViewContainer.alpha = 1
        }
    }
    
    private func addXPCountlbl() {
        view.insertSubview(xpCount_label, at: 3)
        NSLayoutConstraint.activate([
            xpCount_label.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor, constant: -15),
            xpCount_label.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: -itemWidth/2 + 25)
        ])
        fadeXPLabelAndAddProfileView()
    }
    
    private func fadeXPLabelAndAddProfileView() {
        UIView.animate(withDuration: 0.2, delay: 0.8) {
            self.xpCount_label.alpha = 0
        } completion: { success in
            if success {
                self.xpCount_label.removeFromSuperview()
                self.animateProfileViewWithFadeAnimation()
            }
        }
    }
    
    //MARK: Use this Method to Move Yellow View Accross TabItems
    private func moveView(value: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.movingViewTrailingConst.isActive = false
            self.movingViewTrailingConst = self.selectedView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor, constant: -value)
            self.movingViewTrailingConst.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    private func calculateValueToMoveItem(_ selectedIndex: Int) {
        let distanceToMove = (Constants.screenWidth)  - (itemWidth * CGFloat(selectedIndex)) - itemWidth
        moveView(value: selectedIndex == 4 ? distanceToMove + 15: distanceToMove)
    }
}

extension CustomTabBar: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedImage = tabBarController.selectedViewController?.tabBarItem.selectedImage
        selectedImagee = selectedImage
        selectedTitle = tabBarController.selectedViewController?.tabBarItem.title ?? ""
        updateUI()
        updateCurrentItem = selectedIndex
        calculateValueToMoveItem(selectedIndex)
    }
}
