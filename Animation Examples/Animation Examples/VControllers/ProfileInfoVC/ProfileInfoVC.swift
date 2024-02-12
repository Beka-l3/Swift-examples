//
//  ProfileInfoVC.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


protocol ProfileInfoVCDelegate: AnyObject {
    func didTapSettingsPage()
}


final class ProfileInfoVC: UIViewController {
    
    weak var delegate: ProfileInfoVCDelegate?
//    var editVC: _EditProfileInfoVC?
    
    private var userInfo: UserInfo?
    private let uiConfig: ProfileInfoVCUIConfig = .init()
    
    
//    MARK: lifecycle
    init(userInfo: UserInfo? = nil) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configureFrames()
    }
}


extension ProfileInfoVC {
    
    private func configure() {
        uiConfig.rootView = view
        uiConfig.configureUI()
        uiConfig.configureAutolayout()
        
//        uiConfig.containerView.delegate = self
    }
    
    private func configureNavbar() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        standardAppearance.backgroundEffect = UIBlurEffect(style: .light)
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .clear
        scrollEdgeAppearance.backgroundEffect = nil
        scrollEdgeAppearance.shadowColor = .clear
        
        navigationItem.scrollEdgeAppearance = scrollEdgeAppearance
        navigationItem.standardAppearance = standardAppearance
        navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: GConstants.Images.backChevron, style: .plain, target: self, action: #selector(popVC))
        backButton.tintColor = .white
        backButton.title = .empty
        
        let settingsButton = UIBarButtonItem(image: GConstants.Images.gear, style: .plain, target: self, action: #selector(handleSettingsButton))
        settingsButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    private func configureFrames() {
        uiConfig.configureFrames()
    }
}


extension ProfileInfoVC {
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSettingsButton() {
        delegate?.didTapSettingsPage()
    }
}


extension ProfileInfoVC {
    func setData(userInfo: UserInfo) {
        self.userInfo = userInfo
        
        uiConfig.setAvatar(with: userInfo.avatarUrl)
        uiConfig.setDiscount(userInfo.discount)
        
        uiConfig.setNameAndLocation(
            name: userInfo.name + " " + userInfo.surename,
            location: userInfo.location.city + ", " + userInfo.location.country
        )
        
//        uiConfig.setInfoDetails(type: .name, texts: (userInfo.name, userInfo.surename, userInfo.patrioticName))
//        uiConfig.setInfoDetails(type: .contants, texts: (userInfo.email, userInfo.phoneNumber, userInfo.birthday))
//        uiConfig.setInfoDetails(type: .company, texts: (userInfo.company, userInfo.department, userInfo.specialization))
//        
        var items: [ProfileStatisticsView.StatisticsItem] = []
        let gradients = BgGradients.allCases.shuffled()
//
        for (i, statistic) in userInfo.statistics.enumerated() {
            let rawValue = i % gradients.count
            items.append(.item(title: statistic.title, percent: statistic.percent, gradient: gradients[rawValue]))
        }

        uiConfig.setStatisticsItems(items)
    }
}
